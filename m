From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Aug 2013 09:43:52 +0200
Subject: [PATCH V4] ARM: tegra: disable LP2 cpuidle state if PCIe is
 enabled
In-Reply-To: <1376323204-25952-1-git-send-email-swarren@wwwdotorg.org>
References: <1376323204-25952-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130813074351.GB9316@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:00:04AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra20 HW appears to have a bug such that PCIe device interrupts,
> whether they are legacy IRQs or MSI, are lost when LP2 is enabled. To
> work around this, simply disable LP2 if any PCIe devices with interrupts
> are present. Detect this via the IRQ domain map operation. This is
> slightly over-conservative; if a device with an interrupt is present but
> the driver does not actually use them, LP2 will still be disabled.
> However, this is a reasonable trade-off which enables a simpler
> workaround.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v4: Add missing tegra-cpuidle.h, re-write commit description. Add acks.
> 
> v3: Only disable LP2 if a PCIe device that requests an interrupt is
> actually present. This prevents the loss of power-saving when the WAR
> isn't required.

Great, looks good to me and I see that you've applied it to your tree
already. This has been in the works for (literally!) years and it's
quite a relief to see it finally merged.

Thanks a lot!

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/d970174d/attachment.sig>

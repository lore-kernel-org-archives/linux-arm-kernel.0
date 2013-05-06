From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 6 May 2013 22:44:24 +0200
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
In-Reply-To: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
References: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130506204424.GA18286@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 02:39:04PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
> they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
> this, simply disable LP2 if the PCI driver and DT node are both enabled.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Thierry,
> 
> This patch is physically based on next-20130506 so that it doesn't
> conflict with any of the recent cpuidle cleanup work. I'm sending it with
> the expectation that you'll apply it to your PCIe development branch
> though. If you do that, you'll see some conflicts unless you rebase your
> dev branch onto something more recent than next-20130422; I assume you'll
> do that rebase soon enough anyway, but if you weren't planning to, I can
> resend the patch based on your current dev branch.

Yes, I'll be rebasing my development branch soon anyway and I'll pull
this patch into the branch. Thanks for writing it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130506/7e995566/attachment-0001.sig>

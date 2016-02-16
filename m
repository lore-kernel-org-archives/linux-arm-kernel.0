From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Feb 2016 11:37:57 +0100
Subject: [PATCH] ARM: dts: tegra: replace legacy *,wakeup property with
 wakeup-source
In-Reply-To: <1454968543-12035-1-git-send-email-sudeep.holla@arm.com>
References: <1454968543-12035-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160216103757.GA9979@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 09:55:43PM +0000, Sudeep Holla wrote:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "nvidia,wakeup-source" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
> 
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
> 
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts         | 2 +-
>  arch/arm/boot/dts/tegra114-roth.dts            | 2 +-
>  arch/arm/boot/dts/tegra114-tn7.dts             | 2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts      | 2 +-
>  arch/arm/boot/dts/tegra124-nyan.dtsi           | 4 ++--
>  arch/arm/boot/dts/tegra124-venice2.dts         | 2 +-
>  arch/arm/boot/dts/tegra20-harmony.dts          | 2 +-
>  arch/arm/boot/dts/tegra20-paz00.dts            | 2 +-
>  arch/arm/boot/dts/tegra20-seaboard.dts         | 4 ++--
>  arch/arm/boot/dts/tegra20-trimslice.dts        | 2 +-
>  arch/arm/boot/dts/tegra20-ventana.dts          | 2 +-
>  arch/arm/boot/dts/tegra20-whistler.dts         | 2 +-
>  arch/arm/boot/dts/tegra30-apalis-eval.dts      | 2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi          | 2 +-
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts  | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 4 ++--
>  16 files changed, 19 insertions(+), 19 deletions(-)

I've applied this for 4.6, though I took the liberty of splitting this
up into ARM and arm64 patches, since the ARM SoC maintainers prefer it
that way.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/bddd51d9/attachment.sig>

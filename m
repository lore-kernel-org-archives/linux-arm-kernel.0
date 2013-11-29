From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:10:41 +0100
Subject: [PATCH 06/31] ARM: tegra: select the reset framework
In-Reply-To: <1384548866-13141-7-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-7-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129131040.GS22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:01PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra clock driver is built unconditionally when Tegra support is
> enabled. In order to avoid having to ifdef the forthcoming reset driver
> implementation, have ARCH_TEGRA select RESET_CONTROLLER.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 09e740f58b27..15c09294effa 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -14,6 +14,8 @@ config ARCH_TEGRA
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select MIGHT_HAVE_PCI
>  	select PINCTRL
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select RESET_CONTROLLER

I don't think RESET_CONTROLLER is necessary given this:

	menuconfig RESET_CONTROLLER
		bool "Reset Controller Support"
		default y if ARCH_HAS_RESET_CONTROLLER

I suppose that would still make it possible to deselect RESET_CONTROLLER
and cause breakage. Explicitly selecting it avoids that, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/5fb29f1b/attachment.sig>

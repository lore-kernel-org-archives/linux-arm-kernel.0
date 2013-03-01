From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Mar 2013 18:42:12 +0900
Subject: [PATCH 2/2] ARM: mach-shmobile: kzm9g: do not enable
 REGULATOR_DUMMY in defconfig
In-Reply-To: <1360936117-21765-3-git-send-email-horms+renesas@verge.net.au>
References: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
 <1360936117-21765-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130301094212.GH27938@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 10:48:37PM +0900, Simon Horman wrote:
> Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
> There doesn't seem to be any value in setting it here and doing
> so was an error on my part.

Applied to the defconfig branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/kzm9g_defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> This patch depends on "ARM: shmobile: kzm9g: correct smsc regulator registration"
> 
> diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> index 670c3b6..6751c02 100644
> --- a/arch/arm/configs/kzm9g_defconfig
> +++ b/arch/arm/configs/kzm9g_defconfig
> @@ -86,7 +86,6 @@ CONFIG_I2C_SH_MOBILE=y
>  CONFIG_GPIO_PCF857X=y
>  # CONFIG_HWMON is not set
>  CONFIG_REGULATOR=y
> -CONFIG_REGULATOR_DUMMY=y
>  CONFIG_FB=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> -- 
> 1.7.10.4
> 

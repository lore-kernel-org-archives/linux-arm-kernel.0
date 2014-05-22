From: riku.voipio@iki.fi (Riku Voipio)
Date: Thu, 22 May 2014 11:12:02 +0300
Subject: [PATCH RESEND] mmc: dove: fix missing MACH_DOVE dependency
In-Reply-To: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140522081202.GA21151@afflict.kos.to>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 08:02:51PM +0200, Sebastian Hesselbarth wrote:
> DT-enabled Dove moved over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE Kconfig. This slipped through the cracks and now is
> a fix to allow to build Dove's SDHCI driver for mach-mvebu on v3.15-rc.

Dove cubox has usually rootfs on mmc, so this patch is very much needed
for using multiplatform kernel on dove cubox.

Tested-by: Riku Voipio <riku.voipio@iki.fi>

> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8aaf8c1f3f63..37665553ef33 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -168,7 +168,7 @@ config MMC_SDHCI_ESDHC_IMX
>  
>  config MMC_SDHCI_DOVE
>  	tristate "SDHCI support on Marvell's Dove SoC"
> -	depends on ARCH_DOVE
> +	depends on ARCH_DOVE || MACH_DOVE
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
> -- 
> 1.9.1
> 
> 

From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2016 16:46:15 +0100
Subject: [PATCH] arm64: defconfig: remove redundant CONFIG_MMC_BLOCK_MINORS
In-Reply-To: <1459178928-26973-1-git-send-email-leo.yan@linaro.org>
References: <1459178928-26973-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20160329154615.GF6745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 11:28:48PM +0800, Leo Yan wrote:
> There have two patches to add CONFIG_MMC_BLOCK_MINORS twice:
> 22b0898e8 ("arm64: add defconfig options for Allwinner SoCs"),
> 2f85bb09d ("arm64: defconfig: Increase MMC_BLOCK_MINORS to 16");
> 
> So remove redundant CONFIG_MMC_BLOCK_MINORS to only enable once.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f705051..3ad26ff 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -215,7 +215,6 @@ CONFIG_MMC_SPI=y
>  CONFIG_MMC_SUNXI=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_EXYNOS=y
> -CONFIG_MMC_BLOCK_MINORS=16
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_SYSCON=y

Thanks, I'll pick this up with some other pending defconfig updates for
-rc2.

Will

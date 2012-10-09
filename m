From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 09 Oct 2012 17:34:59 +0900
Subject: [PATCH] ARM: EXYNOS5: Remove wrongly placed usb2.0 PHY_CFG
 definition from PMU_REG
In-Reply-To: <1349443590-29901-1-git-send-email-gautam.vivek@samsung.com>
References: <1349443590-29901-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <003b01cda5f8$f84e35c0$e8eaa140$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 05, 2012 10:27 PM Vivek Gautam wrote
> 
> EXYNOS5_USB_CFG macro should actually point to USB20PHY_CFG
> system register (base addr + 0x230). It's wrongly placed in regs-pmu.
> Actual register at offset 0x230 in PMU is SEQ_TRANSITION4.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

As you mentioned, this definition is wrong.
So, it should be removed.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>


> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> index d4e392b..70b2795 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -230,8 +230,6 @@
> 
>  /* For EXYNOS5 */
> 
> -#define EXYNOS5_USB_CFG						S5P_PMUREG(0x0230)
> -
>  #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
>  #define EXYNOS5_MASK_WDTRESET_REQUEST				S5P_PMUREG(0x040C)
> 
> --
> 1.7.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

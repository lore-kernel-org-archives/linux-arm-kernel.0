From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 27 Jan 2010 08:11:40 +0000
Subject: [PATCHv2 01/10] ARM: S3C2443: GPIO: Correct AC97 pin defines
In-Reply-To: <1264571873-14924-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264571873-14924-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100127081140.GK9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:57:53PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> GPIO_E-[5,9] pin functionality was defined incorrectly.
> The patch corrects and adds missing pins.

Ok, should I apply this to the fixes tree and send to linus?
 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/regs-gpio.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> index ebc85c6..fd672f3 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> @@ -406,31 +406,31 @@
>  #define S3C2443_GPE5_SD1_CLK   (0x02 << 10)
>  #define S3C2400_GPE5_EINT5     (0x02 << 10)
>  #define S3C2400_GPE5_TCLK1     (0x03 << 10)
> +#define S3C2443_GPE5_AC_BITCLK (0x03 << 10)
>  
>  #define S3C2410_GPE6_SDCMD     (0x02 << 12)
>  #define S3C2443_GPE6_SD1_CMD   (0x02 << 12)
> -#define S3C2443_GPE6_AC_BITCLK (0x03 << 12)
> +#define S3C2443_GPE6_AC_SDI    (0x03 << 12)
>  #define S3C2400_GPE6_EINT6     (0x02 << 12)
>  
>  #define S3C2410_GPE7_SDDAT0    (0x02 << 14)
>  #define S3C2443_GPE5_SD1_DAT0  (0x02 << 14)
> -#define S3C2443_GPE7_AC_SDI    (0x03 << 14)
> +#define S3C2443_GPE7_AC_SDO    (0x03 << 14)
>  #define S3C2400_GPE7_EINT7     (0x02 << 14)
>  
>  #define S3C2410_GPE8_SDDAT1    (0x02 << 16)
>  #define S3C2443_GPE8_SD1_DAT1  (0x02 << 16)
> -#define S3C2443_GPE8_AC_SDO    (0x03 << 16)
> +#define S3C2443_GPE8_AC_SYNC   (0x03 << 16)
>  #define S3C2400_GPE8_nXDACK0   (0x02 << 16)
>  
>  #define S3C2410_GPE9_SDDAT2    (0x02 << 18)
>  #define S3C2443_GPE9_SD1_DAT2  (0x02 << 18)
> -#define S3C2443_GPE9_AC_SYNC   (0x03 << 18)
> +#define S3C2443_GPE9_AC_nRESET (0x03 << 18)
>  #define S3C2400_GPE9_nXDACK1   (0x02 << 18)
>  #define S3C2400_GPE9_nXBACK    (0x03 << 18)
>  
>  #define S3C2410_GPE10_SDDAT3   (0x02 << 20)
>  #define S3C2443_GPE10_SD1_DAT3 (0x02 << 20)
> -#define S3C2443_GPE10_AC_nRESET (0x03 << 20)
>  #define S3C2400_GPE10_nXDREQ0  (0x02 << 20)
>  
>  #define S3C2410_GPE11_SPIMISO0 (0x02 << 22)
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

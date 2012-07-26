From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 26 Jul 2012 10:09:06 +0800
Subject: [PATCH] mtd: gpmi-nand: fix build error when MXS_DMA is not
 configured
In-Reply-To: <1343268072-20732-1-git-send-email-richard.zhao@freescale.com>
References: <1343268072-20732-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAMiH66E87RgCsx=uvBcSn-4srrgfgp5vWjrzmN41qjgL0UCMmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
  Fabio has submitted a patch .

thanks.

Huang Shijie

On Thu, Jul 26, 2012 at 10:01 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> Fix below build error:
>
> drivers/built-in.o: In function `gpmi_dma_filter':
> clk-fixed-factor.c:(.text+0xab170): undefined reference to `mxs_dma_is_apbh'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/mtd/nand/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 31bb7e5..d097386 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -481,6 +481,7 @@ config MTD_NAND_NANDSIM
>  config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
>          depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
> +       depends on MXS_DMA
>          help
>          Enables NAND Flash support for IMX23 or IMX28.
>          The GPMI controller is very powerful, with the help of BCH
> --
> 1.7.9.5
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

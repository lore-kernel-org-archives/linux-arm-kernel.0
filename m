From: yangbo.lu@freescale.com (Lu Y.B.)
Date: Thu, 26 Nov 2015 02:05:26 +0000
Subject: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
In-Reply-To: <1446788617-35736-1-git-send-email-yangbo.lu@freescale.com>
References: <1446788617-35736-1-git-send-email-yangbo.lu@freescale.com>
Message-ID: <BLUPR0301MB20651CC0B0AE8BF9BF11FDABF2040@BLUPR0301MB2065.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments?
Thanks.


- Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu at freescale.com]
> Sent: Friday, November 06, 2015 1:44 PM
> To: linux-arm-kernel at lists.infradead.org; Catalin Marinas
> Cc: Lu Yangbo-B47093
> Subject: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
> 
> Add the "little-endian" property to fix the issue that eSDHC is not
> working and dumping out "mmc0: Controller never released inhibit bit(s)."
> error messages constantly.
> 
> Fixes: 5461597f6ce0 ("dts/ls2080a: Update DTSI to add support of various
> peripherals")
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index e81cd48..ed45e25 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -269,6 +269,7 @@
>  			clock-frequency = <0>;	/* Updated by bootloader */
>  			voltage-ranges = <1800 1800 3300 3300>;
>  			sdhci,auto-cmd12;
> +			little-endian;
>  			bus-width = <4>;
>  		};
> 
> --
> 2.1.0.27.g96db324

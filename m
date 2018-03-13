From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Tue, 13 Mar 2018 01:39:24 +0000
Subject: [PATCH 2/5] arm64: dts: allwinner: a64: Add watchdog
In-Reply-To: <20180312161050.7647-3-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-3-harald@ccbib.org>
Message-ID: <29bb31fc-dd3d-e9c5-c78e-f8e80f7a95fa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/18 16:10, Harald Geyer wrote:

Hi,

> Add a watchdog node for the A64, automatically enabled on all boards.
> Tested on Olimex Teres I.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 64e452a758fa..ca1b365bc722 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -665,5 +665,11 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		wdt0: watchdog at 1c20ca0 {
> +			compatible = "allwinner,sun6i-a31-wdt";

Please use the recommended way, adding a specific compatible first:

			compatible = "allwinner,sun50i-a64-wdt",
				     "allwinner,sun6i-a31-wdt";

The rest looks correct.

I am just a bit puzzled what's the use of a watchdog on a laptop? I
would expect it being more used in embedded systems? Or is that patch
here actually independent from the Teres I?

Cheers,
Andre.

> +			reg = <0x01c20ca0 0x20>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
> 

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 22 Feb 2016 13:58:23 +0100
Subject: [PATCH] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
In-Reply-To: <1455687741-9625-1-git-send-email-wenyou.yang@atmel.com>
References: <1455687741-9625-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <56CB05EF.9020105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/02/2016 06:42, Wenyou Yang a ?crit :
> From: Josh Wu <josh.wu@atmel.com>
> 
> In sama5d3, sama5d4 chips, pmecc will use the hsmc clock. As pmecc is
> part of HSMC. So move out hsmc_clk from nfc node to nand node.
> 
> Signed-off-by: Josh Wu <rainyfeeling@outlook.com>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

I'm not against this change, but beware, it must be applied in
synchronization with the patch just posted "[PATCH] mtd: atmel_nand:
move the hsmc_clk from nfc node to nand node"

Bye,


> ---
> 
>  arch/arm/boot/dts/sama5d3.dtsi |    2 +-
>  arch/arm/boot/dts/sama5d4.dtsi |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index a532791..a242d27 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -1474,6 +1474,7 @@
>  			atmel,nand-has-dma;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
> +			clocks = <&hsmc_clk>;
>  			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
>  			status = "disabled";
>  
> @@ -1486,7 +1487,6 @@
>  					0xffffc000 0x00000070	/* NFC HSMC regs */
>  					0x00200000 0x00100000	/* NFC SRAM banks */
>  					>;
> -				clocks = <&hsmc_clk>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index b8032bc..1499b33 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -295,6 +295,7 @@
>  			atmel,nand-has-dma;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_nand>;
> +			clocks = <&hsmc_clk>;
>  			status = "disabled";
>  
>  			nfc at 90000000 {
> @@ -306,7 +307,6 @@
>  					0xfc05c000 0x00000070	/* NFC HSMC regs */
>  					0x00100000 0x00100000	/* NFC SRAM banks */
>                                           >;
> -				clocks = <&hsmc_clk>;
>  				atmel,write-by-sram;
>  			};
>  		};
> 


-- 
Nicolas Ferre

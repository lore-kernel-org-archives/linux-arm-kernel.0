From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 31 Aug 2017 13:16:07 -0700
Subject: [PATCH 1/2] ARM: dts: Add the CLCD controller to Cygnus.
In-Reply-To: <20170831185416.8181-1-eric@anholt.net>
References: <20170831185416.8181-1-eric@anholt.net>
Message-ID: <3a947d06-53cc-bb28-86de-0ddb5c6b853c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

mode is correct, location in file needs to be moved.


On 17-08-31 11:54 AM, Eric Anholt wrote:
> This doesn't yet enable it on any particular platform, as we still
> need a panel driver for bcm911360_entphn.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> These bits are just carving off a little bit of my 911360_entphn panel
> series, to reduce conflicts when rebasing (which I just did for
> testing pl111 changes for cygnus regressions).  I'm waiting to get my
> current RPi panel driver in before working on the 911360 panel again.
>
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 7c957ea06c66..74f73ff24aec 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -575,6 +575,16 @@
>   			status = "disabled";
>   		};
>   
> +		clcd: clcd at 180a0000 {
please place in correct address ordered location in file
> +			compatible = "arm,pl111", "arm,primecell";
> +			reg = <0x180a0000 0x1000>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";
> +			clocks = <&axi41_clk>, <&apb_clk>;
> +			clock-names = "clcdclk", "apb_pclk";
> +			status = "disabled";
> +		};
> +
>   		keypad: keypad at 180ac000 {
>   			compatible = "brcm,bcm-keypad";
>   			reg = <0x180ac000 0x14c>;

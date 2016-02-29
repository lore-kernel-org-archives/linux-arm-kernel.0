From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 1 Mar 2016 00:55:38 +0100
Subject: [PATCH 6/8] ARM64: dts: amlogic: Add Tronsmart Vega S95 configs
In-Reply-To: <1456789465-2962-7-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-7-git-send-email-afaerber@suse.de>
Message-ID: <56D4DA7A.6020805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.03.2016 um 00:44 schrieb Andreas F?rber:
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> new file mode 100644
> index 000000000000..f8c78beb4376
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -0,0 +1,73 @@
[...]
> +#include "meson-gxbb.dtsi"
> +
> +/ {
> +	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		serial1 = &uart_A;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	soc {
> +		uart_A: serial at c11084c0 {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0x0 0xc11084c0 0x0 0x14>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&xtal>;
> +			status = "disabled";
> +		};
> +
> +		uart_AO: serial at c81004c0 {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0x0 0xc81004c0 0x0 0x14>;
> +			interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&xtal>;
> +		};

Doh. These two nodes and their aliases should probably go into
meson-gxbb.dtsi (3/8).

> +	};
> +};

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)

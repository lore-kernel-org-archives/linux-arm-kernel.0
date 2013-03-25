From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 21:44:51 +0100
Subject: [PATCH v2] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130325202408.0337ab6f@armhf>
References: <20130325202408.0337ab6f@armhf>
Message-ID: <5150B743.9040206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 08:24 PM, Jean-Francois Moine wrote:
> The 88AP510 chip (Marvell Dove) contains a LCD controller, a display
> controller and two audio controllers.
>
> Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
> ---
> v2 from Sebastian Hesselbarth remarks
>     - better names for the devices
>     - fix bad i2s interrupt controller
>     - 2 irq's by audio controller
>     - display controller added
> ---
>   arch/arm/boot/dts/dove.dtsi |   38 +++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index f7509ca..4f5cfbf 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -253,5 +253,43 @@
>   				dmacap,xor;
>   			};
>   		};
> +
> +		lcd0: lcd-controller at 820000 {
> +			compatible = "marvell,dove-lcd";
> +			reg =<0x820000 0x1c8>;
> +			interrupts =<47>;
> +			status = "disabled";
> +		};
> +
> +		lcd1: lcd-controller at 810000 {
> +			compatible = "marvell,dove-lcd";
> +			reg =<0x810000 0x1c8>;
> +			interrupts =<46>;
> +			status = "disabled";
> +		};
> +
> +		i2s0: audio-controller at b0000 {
> +			compatible = "marvell,kirkwood-i2s";
> +			reg =<0xb0000 0x4000>;
> +			interrupts =<19>,<20>;
> +			clocks =<&gate_clk 12>;
> +			status = "disabled";
> +		};
> +
> +		i2s1: audio-controller at b4000 {
> +			compatible = "marvell,kirkwood-i2s";
> +			reg =<0xb4000 0x4000>;
> +			interrupts =<21>,<22>;
> +			clocks =<&gate_clk 13>;
> +			status = "disabled";
> +		};
> +
> +		/* display controller and image rotation engine */
> +		dcon: display-controller at 830000 {
> +			compatible = "marvell,dove-dcon";
> +			reg =<0x830000 0xc8>,<0x831000 0x8c>;

nit: first dcon register block ends at 0xc4 not 0xc8

Otherwise,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +			interrupts =<45>;
> +			status = "disabled";
> +		};
>   	};
>   };

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Aug 2013 12:13:07 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130828113459.48ecbb34@armhf>
References: <20130828113459.48ecbb34@armhf>
Message-ID: <521DCD33.2070008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2013 11:34 AM, Jean-Francois Moine wrote:
> This patch adds the nodes to instantiate the audio devices of the Dove
> boards.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   arch/arm/boot/dts/dove.dtsi                  | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 499abad..78227e2 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -573,6 +573,24 @@
>   					phy-handle = <&ethphy>;
>   				};
>   			};
> +
> +			i2s0: audio-controller at b0000 {
> +				compatible = "marvell,mvebu-audio";

[added Gregory to Cc]

Jean-Francois,

as Mark Brown already took the bindings patch for above generic
compatible, how are we going to discriminate different
implementations/features of Dove, Kirkwood, and Armada 370?

Sebastian

> +				reg = <0xb0000 0x2210>;
> +				interrupts = <19>, <20>;
> +				clocks = <&gate_clk 12>;
> +				clock-names = "internal";
> +				status = "disabled";
> +			};
> +
> +			i2s1: audio-controller at b4000 {
> +				compatible = "marvell,mvebu-audio";
> +				reg = <0xb4000 0x2210>;
> +				interrupts = <21>, <22>;
> +				clocks = <&gate_clk 13>;
> +				clock-names = "internal";
> +				status = "disabled";
> +			};
>   		};
>   	};
>   };
>
>

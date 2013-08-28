From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Aug 2013 23:49:12 +0400
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130828113459.48ecbb34@armhf>
References: <20130828113459.48ecbb34@armhf>
Message-ID: <521E5438.90109@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/28/2013 01:34 PM, Jean-Francois Moine wrote:

> This patch adds the nodes to instantiate the audio devices of the Dove
> boards.

> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   arch/arm/boot/dts/dove.dtsi                  | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

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

     According to ePAPR [1] the node should be called "sound", not 
"audio-controller".

> +				compatible = "marvell,mvebu-audio";
> +				reg = <0xb0000 0x2210>;
> +				interrupts = <19>, <20>;
> +				clocks = <&gate_clk 12>;
> +				clock-names = "internal";
> +				status = "disabled";
> +			};
> +
> +			i2s1: audio-controller at b4000 {

    Same comment.

> +				compatible = "marvell,mvebu-audio";
> +				reg = <0xb4000 0x2210>;
> +				interrupts = <21>, <22>;
> +				clocks = <&gate_clk 13>;
> +				clock-names = "internal";
> +				status = "disabled";
> +			};

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

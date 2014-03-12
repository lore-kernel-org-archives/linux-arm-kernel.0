From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 13 Mar 2014 00:17:27 +0300
Subject: [PATCH 4/6] ARM: mvebu: Add support for NAND controller in Armada
 38x SoC
In-Reply-To: <1394637404-7651-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1394637404-7651-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5320CEE7.6020506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/12/2014 06:16 PM, Ezequiel Garcia wrote:

> The Armada 38x SoC family has a NAND controller, compatible
> with the controller in Armada 370/375/XP SoCs. Add support for
> it in the devicetree file.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)

> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 76cc27e..18d8f80 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -345,6 +345,16 @@
>   				clocks = <&mainpll>;
>   				clock-output-names = "nand";
>   			};
> +
> +			nand at d0000 {

    ePAPR standard [1] tells us:

The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model. If appropriate, the name should 
be one of the following choices:

[...]
? flash

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

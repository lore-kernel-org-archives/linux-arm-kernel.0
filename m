From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 13 Mar 2014 23:55:29 +0300
Subject: [PATCH v2 3/6] ARM: mvebu: Add the Core Divider clock to Armada
 38x SoCs
In-Reply-To: <1394739542-30017-4-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1394739542-30017-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1394739542-30017-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <53221B41.2030001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/13/2014 10:38 PM, Ezequiel Garcia wrote:

> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

> The Armada 38x SoC family has a clock provider called "Core Divider",
> derived from the fixed 2 GHz main PLL clock. This is similar to the
> one on A370, A375 and AXP.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   arch/arm/boot/dts/armada-38x.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 38fc3a0..76cc27e 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -337,6 +337,14 @@
>   				compatible = "marvell,orion-mdio";
>   				reg = <0x72004 0x4>;
>   			};
> +
> +			coredivclk: corediv-clock at e4250 {

    I would suggest naming the device just "clock at e4250" on the same grounds 
of having the generic device names.

WBR, Sergei

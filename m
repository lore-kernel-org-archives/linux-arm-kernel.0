From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 27 Aug 2013 10:00:05 +0200
Subject: [PATCH v3 2/2] ARM: at91/dt: define phy available on sama5d3
 mother board
In-Reply-To: <1377589142-3758-1-git-send-email-b.brezillon@overkiz.com>
References: <1377589007-3684-1-git-send-email-b.brezillon@overkiz.com>
 <1377589142-3758-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <521C5C85.2060007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2013 09:39, Boris BREZILLON :
> This patch describe the phy used on atmel sama5d3 mother board:
>   - phy address
>   - phy interrupt pin
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   arch/arm/boot/dts/sama5d3xmb.dtsi |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index 8a9e05d..dba739b 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -81,6 +81,14 @@
>
>   			macb1: ethernet at f802c000 {
>   				phy-mode = "rmii";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				phy0: ethernet-phy at 1 {
> +					interrupt-parent = <&pioE>;
> +					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> +					reg = <1>;
> +				};
>   			};
>
>   			pinctrl at fffff200 {
>


-- 
Nicolas Ferre

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 14 Aug 2013 09:43:59 +0200
Subject: [PATCH 1/1] ARM: at91: at91sam9260: add missing pinctrl-names
 on mmc
In-Reply-To: <1373882719-9940-1-git-send-email-plagnioj@jcrosoft.com>
References: <1373882719-9940-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <520B353F.9070605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/2013 12:05, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/boot/dts/at91sam9260.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index c7ccbcb..56ee828 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -572,6 +572,7 @@
>   				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				pinctrl-names = "default";

Ok, but there is no pinctrl property in this node: maybe it would be 
good to have a default entry for this.

It is then overloaded in arch/arm/boot/dts/animeo_ip.dts for instance...

Can you please add one?

Bye,

>   				status = "disabled";
>   			};
>
>


-- 
Nicolas Ferre

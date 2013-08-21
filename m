From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 21 Aug 2013 10:56:01 +0200
Subject: [PATCH v2] ARM: at91: at91sam9260: add missing pinctrl on mmc
In-Reply-To: <52147553.2010305@atmel.com>
References: <1377070957-24984-1-git-send-email-ludovic.desroches@atmel.com>
 <52147553.2010305@atmel.com>
Message-ID: <20130821085601.GH5149@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 10:07:47AM +0200, Nicolas Ferre wrote:
> On 21/08/2013 09:42, ludovic.desroches at atmel.com :
> >From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> >pinctrl-names was missing causing mmc pinctrl to never be requested. Moreover,
> >add minimal pin configuration to not cause error if overloading is forgotten
> >in board files.
> >
> >Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> (modified the "interrupts" property to add the macro definition).
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

After discussing with Jean-Christophe keeping the first version of the patch
seems a better choice because the user will be notified if he forgets to
overload pin configuration instead of thinking that everything goes right and
having a default pin configuration that could not fit its configuration.

> 
> stacked in at91-3.12-dt.
> 
> Due to macro change, I can't tag it for -stable. We have to remember
> to add it when it is accepted upstream.
> 
> thanks.
> 
> >---
> >
> >v2:
> >   - add minimal pin configuration
> >
> >  arch/arm/boot/dts/at91sam9260.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> >index 84c4bef..b4de52a 100644
> >--- a/arch/arm/boot/dts/at91sam9260.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9260.dtsi
> >@@ -477,6 +477,8 @@
> >  				interrupts = <9 4 0>;
> >  				#address-cells = <1>;
> >  				#size-cells = <0>;
> >+				pinctrl-names = "default";
> >+				pinctrl-0 = <&pinctrl_mmc0_clk &pinctrl_mmc0_slot1_cmd_dat0>;
> >  				status = "disabled";
> >  			};
> >
> >
> 
> 
> -- 
> Nicolas Ferre

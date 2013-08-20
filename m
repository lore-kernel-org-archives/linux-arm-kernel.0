From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 20 Aug 2013 18:24:42 +0200
Subject: [PATCH 1/1] ARM: at91: at91sam9260: add missing pinctrl-names on
 mmc
In-Reply-To: <520B353F.9070605@atmel.com>
References: <1373882719-9940-1-git-send-email-plagnioj@jcrosoft.com>
 <520B353F.9070605@atmel.com>
Message-ID: <20130820162442.GF5149@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 09:43:59AM +0200, Nicolas Ferre wrote:
> On 15/07/2013 12:05, Jean-Christophe PLAGNIOL-VILLARD :
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> >---
> >  arch/arm/boot/dts/at91sam9260.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> >index c7ccbcb..56ee828 100644
> >--- a/arch/arm/boot/dts/at91sam9260.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9260.dtsi
> >@@ -572,6 +572,7 @@
> >  				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
> >  				#address-cells = <1>;
> >  				#size-cells = <0>;
> >+				pinctrl-names = "default";
> 
> Ok, but there is no pinctrl property in this node: maybe it would be
> good to have a default entry for this.
> 
> It is then overloaded in arch/arm/boot/dts/animeo_ip.dts for instance...
> 

Yes it is overloaded in arch/arm/boot/dts/at91sam9g20ek_common.dtsi.

mmc0 pinctrl configuration is set in at91sam9260.dtsi that is ok but do we have
to put a minimal pinctrl property as the mmc clock pinctrl? It is board
relative and no device related. So maybe it is not the right place then I am
wondering if pinctrl-names should be set in at91sam9260.dtsi...

> Can you please add one?
> 
> Bye,
> 
> >  				status = "disabled";
> >  			};
> >
> >
> 
> 
> -- 
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

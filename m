From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 19 Apr 2013 16:57:12 +0200
Subject: [PATCH 1/5] ARM: at91: at91sam9x5 RTC is not compatible with
 at91rm9200 one
In-Reply-To: <51715988.9060606@cogentembedded.com>
References: <cover.1366289869.git.nicolas.ferre@atmel.com>
 <864f10566b35864d469f6ff2913b9afaa0c69350.1366289869.git.nicolas.ferre@atmel.com>
 <51714C74.2030907@cogentembedded.com> <51714F47.5040006@atmel.com>
 <51715988.9060606@cogentembedded.com>
Message-ID: <20130419145712.GG4998@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:49 Fri 19 Apr     , Sergei Shtylyov wrote:
> On 19-04-2013 18:05, Nicolas Ferre wrote:
> 
> >>>Due to a bug with RTC IMR, we cannot consider at91sam9x5 RTC compatible
> >>>with the previous one. Modify DT compatibility string, even if the driver
> >>>is not yet modified to take it into account.
> 
> >>>Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>>---
> >>>   arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> >>>diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
> >>>b/arch/arm/boot/dts/at91sam9x5.dtsi
> >>>index a3d4464..58747f3 100644
> >>>--- a/arch/arm/boot/dts/at91sam9x5.dtsi
> >>>+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> >>>@@ -564,7 +564,7 @@
> >>>               };
> >>>
> >>>               rtc at fffffeb0 {
> >>>-                compatible = "atmel,at91rm9200-rtc";
> >>>+                compatible = "atmel,at91sam9x5-rtc";
> 
> >>    Do not use wildcards in the "compatible" prop values (I guess 'x' is
> >>a wildcard).
> 
> >Well, it is for naming a series of hardware, not for giving a generic
> >name that could cover different hardware.
> 
> >In the sense of Atmel it is our way to call the at91sam9x5 series of
> >SoC: you will see that the code that covers these SoCs is always named
> >like this.
> >In fact, the hardware contained in these SoC cannot be different from
> >one flavor of the family to the other.
> 
>    Nevertheless, the wildcards shouldn't be used. Use the name of
> e.g. the first member of the family.
we use this across others bindings

at91sam9x5 is the name of the Family

Best Regards,
J.

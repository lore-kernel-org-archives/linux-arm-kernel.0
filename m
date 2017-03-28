From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:34:52 +0200
Subject: [PATCH] ATM: dts: at91: sama5d2_xplained: add pwm controller
In-Reply-To: <60c37963-509f-7764-9554-520694294909@microchip.com>
References: <1487838778-13473-1-git-send-email-claudiu.beznea@microchip.com>
 <20170223084241.6eqm5jxe4t7fpn6a@piout.net>
 <60c37963-509f-7764-9554-520694294909@microchip.com>
Message-ID: <20170328113452.bje7har2ymbr32ad@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/03/2017 at 14:04:25 +0300, m18063 wrote:
> >> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> >> index cd459e8..e88785e 100644
> >> --- a/arch/arm/boot/dts/sama5d2.dtsi
> >> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> >> @@ -1098,6 +1098,14 @@
> >>  				status = "disabled";
> >>  			};
> >>  
> >> +			pwm0: pwm at f802c000 {
> >> +				compatible = "atmel,sama5d2-pwm";
> > This compatible is not documented and is not used in any driver. Is that
> > really working?
> 
> At the moment I send this patch another driver patch was send
> to used this device tree bindings and also to document it.
> Meanwhile you reviewed also that other patch.
> 

Yes, I received that patch first, without the other ones. You should
have put everything in the same series.

> Please let me know if you want to send again this DT patch since
> I didn't yet receive any inputs its v2.
> 

I'll take it once the pwm patch are taken by Thierry because it is not
useful as-is, unless you use:
 compatible = "atmel,sama5d2-pwm", "atmel,sama5d3-pwm";


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

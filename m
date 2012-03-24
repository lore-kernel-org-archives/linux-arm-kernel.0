From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Mar 2012 19:10:06 +0000
Subject: [PATCH 4/4] arm: at91: dt: sam9g25ek add mci support
In-Reply-To: <4F6B3CCD.7070105@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 <1332352994-20983-5-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3CCD.7070105@atmel.com>
Message-ID: <20120324191006.8FC3A3E0AD0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Mar 2012 15:53:01 +0100, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 03/21/2012 07:03 PM, ludovic.desroches at atmel.com :
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I think you really mean "Acked-by".  It is only appropriate to add a
"Signed-off-by" tag when you have actually picked up and either
committed or reposted a patch.  When replying to a patch on the
mailing list and giving your okay, the correct tag is either
"Acked-by" or "Reviewed-by"  (The difference being that "Acked-by"
infers that you have some authority over the areas touched by the
patch).

See Documentation/SubmittingPatches

g.

> 
> > ---
> >  arch/arm/boot/dts/at91sam9g25ek.dts |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
> > index 7a13d09..960de2b 100644
> > --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> > +++ b/arch/arm/boot/dts/at91sam9g25ek.dts
> > @@ -32,6 +32,22 @@
> >  				phy-mode = "rmii";
> >  				status = "okay";
> >  			};
> > +
> > +			mmc0: mmc at f0008000 {
> > +				status = "okay";
> > +				slot at 0 {
> > +					bus-width = <4>;
> > +					cd-gpios = <&pioD 15 0>;
> > +				};
> > +			};
> > +
> > +			mmc1: mmc at f000c000 {
> > +				status = "okay";
> > +				slot at 0 {
> > +					bus-width = <4>;
> > +					cd-gpios = <&pioD 14 0>;
> > +				};
> > +			};
> >  		};
> >  
> >  		usb0: ohci at 00600000 {
> 
> 
> -- 
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

From: Hong.Xu@atmel.com (Xu, Hong)
Date: Mon, 16 Apr 2012 02:28:22 +0000
Subject: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
In-Reply-To: <4F885260.9080900@atmel.com>
References: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
 <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
 <4F885260.9080900@atmel.com>
Message-ID: <A92DB5DF46DBC241980A99BFD8A00AEE0F629640@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: Saturday, April 14, 2012 12:21 AM
> To: Xu, Hong
> Cc: plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
> 
> Hi Xu Hong,
> 
> Some comments below...
> 
> (you may also include devicetree-discuss at lists.ozlabs.org as well)
> 
> On 04/12/2012 08:26 AM, Hong Xu :
> > Added AT91SAM9N12 SoC DT file, as well as the board definition file
> > for AT91SAM9N12-EK
> >
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> > ---
> >  arch/arm/boot/dts/at91sam9n12.dtsi  |  223
> +++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/at91sam9n12ek.dts |  111 +++++++++++++++++
> >  2 files changed, 334 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
> >  create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
> >
[...]
> > +
> > +			shdwc at fffffe10 {
> > +				compatible = "atmel,at91sam9n12-shdwc";
> 
> I think that shdwc is compatible with "atmel,at91sam9x5-shdwc", is not it?
> 
> 
> > +				reg = <0xfffffe10 0x10>;
> > +			};
> > +
> > +			tcb0: timer at f8008000 {
> > +				compatible = "atmel,at91sam9n12-tcb";
> 
> Here also, I suspect a compatibility with: "atmel,at91sam9x5-tcb"
> 
Exactly. Although a generic name sounds nicer. :-)

> > +				reg = <0xf8008000 0x100>;
> > +				interrupts = <17 4>;
> > +			};
> > +
> > +			tcb1: timer at f800c000 {
> > +				compatible = "atmel,at91sam9n12-tcb";
> 
> Ditto.
> 
Ditto.
> > +				reg = <0xf800c000 0x100>;
> > +				interrupts = <17 4>;
> > +			};
> > +
[...]
> > diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts
> b/arch/arm/boot/dts/at91sam9n12ek.dts
> > new file mode 100644
> > index 0000000..56b012f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> > @@ -0,0 +1,111 @@
> > +/*
[...]
> > +	ahb {
> > +		apb {
> > +			dbgu: serial at fffff200 {
> > +				status = "okay";
> > +			};
> > +
> > +			tcb0: timer at f8008000 {
> > +				status = "okay";
> 
> No need for this node, tcb0 is already enabled.
> 
> > +			};
> > +
> > +			tcb1: timer at f800c000 {
> > +				status = "okay";
> 
> Ditto.
> 

OK, both tcb(s) are enabled in SoC DT file.

> > +			};
> > +		};
> > +
> > +		nand0: nand at 40000000 {
> > +			nand-bus-width = <8>;
> > +			nand-ecc-mode = "hw";
> 
> No, HW PMECC code is not included in mainline yet. You should submit
> 9n12 with sw ECC for the moment. We will change this argument afterwards.
> 
> 

My typo. :)

> > +			/*
> > +			nand-on-flash-bbt;
> > +			*/
> 
> You can keep this one, or remove it completely.
> 
> > +			atmel,pmecc-cap = <2>;
> > +			atmel,sector-size = <512>;
> 
> Later for those PMECC related bindings. You can submit them with the
> PMECC series BTW.
> 
OK.

Thanks

BR,
Eric
> > +			status = "okay";
> > +
> > +			boot at 0 {
> > +				label = "bootstrap/uboot/kernel";
> > +				reg = <0x0 0x400000>;
> > +			};
[...]

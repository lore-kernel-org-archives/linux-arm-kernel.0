From: harald@ccbib.org (Harald Geyer)
Date: Tue, 13 Mar 2018 11:03:33 +0100
Subject: [PATCH 2/5] arm64: dts: allwinner: a64: Add watchdog
In-Reply-To: <29bb31fc-dd3d-e9c5-c78e-f8e80f7a95fa@arm.com>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-3-harald@ccbib.org>
 <29bb31fc-dd3d-e9c5-c78e-f8e80f7a95fa@arm.com>
Message-ID: <E1evgmL-0000KW-JP@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andr? Przywara writes:
> On 12/03/18 16:10, Harald Geyer wrote:
> > Add a watchdog node for the A64, automatically enabled on all boards.
> > Tested on Olimex Teres I.
> > 
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 64e452a758fa..ca1b365bc722 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -665,5 +665,11 @@
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  		};
> > +
> > +		wdt0: watchdog at 1c20ca0 {
> > +			compatible = "allwinner,sun6i-a31-wdt";
> 
> Please use the recommended way, adding a specific compatible first:
> 
> 			compatible = "allwinner,sun50i-a64-wdt",
> 				     "allwinner,sun6i-a31-wdt";

I tried to follow the style most commonly used in the rest of the file,
but I can add the new string to the binding documentation and use it here.

> The rest looks correct.
> 
> I am just a bit puzzled what's the use of a watchdog on a laptop?

I guess the same as the watchdog on my x86 PC - debugging/testing software
using watchdogs. ;)

> I
> would expect it being more used in embedded systems? Or is that patch
> here actually independent from the Teres I?

Yes, I could have sent it as independent patch, but I figured merging
is easier if there aren't independent patches touching the same file at
the same time.

I mostly added support for the watchdog because it was listed in the
wiki as untested and it cost me virtually no time to run a few tests while
working on the teres.

Thanks,
Harald

> Cheers,
> Andre.
> 
> > +			reg = <0x01c20ca0 0x20>;
> > +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> >  	};
> >  };
> > 
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w

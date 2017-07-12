From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Jul 2017 15:59:27 +0200
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2: use sama5d2 compatible
 string for SMC
In-Reply-To: <20170711092556.mukp4umf4r4etqvt@dell>
References: <20170711074015.30440-1-ludovic.desroches@microchip.com>
 <20170711074015.30440-4-ludovic.desroches@microchip.com>
 <029b80a8-2d3f-11b4-d4df-55f5fc48c8e7@microchip.com>
 <20170711075829.5rzdrjgao6efiuj2@rfolt0960.corp.atmel.com>
 <20170711080853.uxdmxocq5nhrp7vq@rfolt0960.corp.atmel.com>
 <20170711092556.mukp4umf4r4etqvt@dell>
Message-ID: <20170712135927.v2mlzknsn4w4o2r2@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2017 at 10:25:56 +0100, Lee Jones wrote:
> On Tue, 11 Jul 2017, Ludovic Desroches wrote:
> 
> > On Tue, Jul 11, 2017 at 09:58:29AM +0200, Ludovic Desroches wrote:
> > > On Tue, Jul 11, 2017 at 09:52:58AM +0200, Nicolas Ferre wrote:
> > > > On 11/07/2017 at 09:40, Ludovic Desroches wrote:
> > > > > A new compatible string has been introduced for sama5d2 SMC to allow to
> > > > > manage the registers mapping change.
> > > > > 
> > > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > > > > index 4fcd5bb219e3..60e69aeacbdb 100644
> > > > > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > > > > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > > > > @@ -1048,7 +1048,7 @@
> > > > >  			};
> > > > >  
> > > > >  			hsmc: hsmc at f8014000 {
> > > > > -				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
> > > > > +				compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
> > > > 
> > > > You'd better use something like:
> > > >  compatible = "atmel,sama5d2-smc", "atmel,sama5d3-smc", "syscon", "simple-mfd";
> > > 
> > > But it's not true, during data interface setup, we will write values in
> > > the wrong place if we fallback on "atmel,sama5d3-smc".
> > > 
> > > Regards
> > > 
> > > Ludovic
> > > 
> > > > 
> > > > So that this patch is independent from the rest of the series and
> > > > we can avoid to having to synchronize with mfd or mtd/nand for this part.
> > 
> > If Lee and Boris agree, maybe the series can go through AT91.
> 
> That's fine, but if the series goes though another tree, I will
> require a pull-request.
> 
> I am also happy to carry though the MFD tree (and will of course send
> out a PR to the other affected Maintainers).
> 

I think the easiest is that you take the first two patches through mfd
and I'll take the third one through at91.

Our plan is to get everything fixed for the final 4.13 (I'll send the DT
as a fix, on top of 4.13-rc1). Is that OK for you ?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

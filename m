From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Dec 2015 22:36:31 +0100
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <20151204184706.GO23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <87wpsunn82.fsf@saruman.tx.rr.com> <20151204184706.GO23396@atomide.com>
Message-ID: <5617214.abxPrpfVaF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 10:47:07 Tony Lindgren wrote:
> > Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> > > @@ -174,12 +182,44 @@
> > >             };
> > >  
> > >             edma: edma at 49000000 {
> > > -                   compatible = "ti,edma3";
> > > -                   ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > > -                   reg =   <0x49000000 0x10000>,
> > > -                           <0x44e10f90 0x40>;
> > > +                   compatible = "ti,edma3-tpcc";
> > > +                   ti,hwmods = "tpcc";
> > > +                   reg =   <0x49000000 0x10000>;
> > > +                   reg-names = "edma3_cc";
> > >                     interrupts = <12 13 14>;
> > > -                   #dma-cells = <1>;
> > > +                   interrupt-names = "edma3_ccint", "emda3_mperr",
> > > +                                     "edma3_ccerrint";
> > > +                   dma-requests = <64>;
> > > +                   #dma-cells = <2>;
> > > +
> > > +                   ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> > > +                              <&edma_tptc2 0>;
> > > +
> > > +                   ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> > 
> > can you explain this property here ? Are you setting bits 20 and 21 on a
> > 16-bit field ?
> 
> I think it's an arry of u16 dma channels.. But could it be just /bits/ 8
> instead of /bits/ 16?
> 

Please just drop the /bits/ 16 and use normal cells.

	Arnd

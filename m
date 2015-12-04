From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Dec 2015 13:51:15 -0800
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <5617214.abxPrpfVaF@wuerfel>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <87wpsunn82.fsf@saruman.tx.rr.com>
 <20151204184706.GO23396@atomide.com> <5617214.abxPrpfVaF@wuerfel>
Message-ID: <20151204215115.GP23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [151204 13:38]:
> On Friday 04 December 2015 10:47:07 Tony Lindgren wrote:
> > > Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> > > > @@ -174,12 +182,44 @@
> > > >             };
> > > >  
> > > >             edma: edma at 49000000 {
> > > > -                   compatible = "ti,edma3";
> > > > -                   ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > > > -                   reg =   <0x49000000 0x10000>,
> > > > -                           <0x44e10f90 0x40>;
> > > > +                   compatible = "ti,edma3-tpcc";
> > > > +                   ti,hwmods = "tpcc";
> > > > +                   reg =   <0x49000000 0x10000>;
> > > > +                   reg-names = "edma3_cc";
> > > >                     interrupts = <12 13 14>;
> > > > -                   #dma-cells = <1>;
> > > > +                   interrupt-names = "edma3_ccint", "emda3_mperr",
> > > > +                                     "edma3_ccerrint";
> > > > +                   dma-requests = <64>;
> > > > +                   #dma-cells = <2>;
> > > > +
> > > > +                   ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> > > > +                              <&edma_tptc2 0>;
> > > > +
> > > > +                   ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> > > 
> > > can you explain this property here ? Are you setting bits 20 and 21 on a
> > > 16-bit field ?
> > 
> > I think it's an arry of u16 dma channels.. But could it be just /bits/ 8
> > instead of /bits/ 16?
> > 
> 
> Please just drop the /bits/ 16 and use normal cells.

Yeah agreed, makes things less confusing for sure :)

Tony

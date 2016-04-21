From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Apr 2016 10:26:36 +0100
Subject: [PATCH v5 3/7] arm64/perf: Changed events naming as per ARM ARM
In-Reply-To: <20160421092107.GA3673@ashok.sekar@broadcom.com>
References: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
 <1461092062-7484-4-git-send-email-ashoks@broadcom.com>
 <20160420133456.GJ11453@leverpostej>
 <20160421092107.GA3673@ashok.sekar@broadcom.com>
Message-ID: <20160421092636.GB6879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 02:21:10AM -0700, Ashok Kumar wrote:
> On Wed, Apr 20, 2016 at 02:34:56PM +0100, Mark Rutland wrote:
> > On Tue, Apr 19, 2016 at 11:54:18AM -0700, Ashok Kumar wrote:
> > >  /* ARMv8 Cortex-A53 specific event types. */
> > >  #define ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			0xC2
> > >  
> > >  /* ARMv8 Cavium ThunderX specific event types. */
> > > -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_MISS_ST			0xE9
> > > -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_PREF_ACCESS		0xEA
> > > -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_PREF_MISS		0xEB
> > > -#define ARMV8_THUNDER_PERFCTR_L1_ICACHE_PREF_ACCESS		0xEC
> > > -#define ARMV8_THUNDER_PERFCTR_L1_ICACHE_PREF_MISS		0xED
> > > +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_MISS_ST			0xE9
> > > +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_PREF_ACCESS		0xEA
> > > +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_PREF_MISS		0xEB
> > > +#define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
> > > +#define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
> > 
> > I'm not sure of the value of renaming these. I would think these should
> > match whatever is in the documentation for Cortex-A53 and ThunderX
> > respectively (and there's the obvious PREFETCH/PREF difference
> > remaining).
> I have changed them to PREF and will post it in v6.
> I checked table 12.28 in Cortex-A53 MPCore Processor TRM r0p4.
> For 0xc2, event mnemonic is not available but event name says 
> "Linefill because of prefetch".

Ok. Plese mention that explicitly in the commit message for v6, as it's
non-obvious.

Otherwise that sounds fine to me (and my Reviewed-by stands). I'll leave
the final say to Will.

Thanks,
Mark.

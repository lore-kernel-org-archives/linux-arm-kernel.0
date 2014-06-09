From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 9 Jun 2014 17:40:05 +0100
Subject: [PATCH] arm64: Add flush_cache_vmap call in __early_set_fixmap
In-Reply-To: <20140609133859.GB18487@localhost>
References: <1402050590-23877-1-git-send-email-leif.lindholm@linaro.org>
 <1402065449.15402.2.camel@deneb.redhat.com>
 <20140606145324.GE4179@bivouac.eciton.net>
 <1402067373.15402.9.camel@deneb.redhat.com>
 <20140609110356.GD25590@arm.com>
 <20140609132429.GF4179@bivouac.eciton.net>
 <20140609133859.GB18487@localhost>
Message-ID: <20140609163954.GA22876@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 02:38:59PM +0100, Catalin Marinas wrote:
> On Mon, Jun 09, 2014 at 02:24:29PM +0100, Leif Lindholm wrote:
> > On Mon, Jun 09, 2014 at 12:03:56PM +0100, Catalin Marinas wrote:
> > > A quick grep through the kernel shows that we have other set_pte() calls
> > > without additional dsb() like create_mapping(), I think kvm_set_pte() as
> > > well.
> > > 
> > > So I'm proposing an alternative patch (which needs some benchmarking as
> > > well to see if anything is affected, maybe application startup time).
> > 
> > I'm happy for any fix which can be included in 3.16.
> 
> Steve Capper made a point about performance. He'll follow up.

Hi :-).
My concern was initially about splitting THPs, as with a 64K granule,
we will have 2048 calls to set_pte_at in a loop. Having thought about
it, these should be relatively rare events though.

There will be an impact on various aspects of the memory system (for
instance fork), but this will need to be measured.

Cheers,
-- 
Steve

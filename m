From: steve.capper@arm.com (Steve Capper)
Date: Tue, 21 Nov 2017 11:15:59 +0000
Subject: [PATCH 1/2] arm64: Re-order reserved_ttbr0 in linker script
In-Reply-To: <20171120162521.gn37lrfwgw2aabv6@lakrids.cambridge.arm.com>
References: <20171117114143.26577-1-steve.capper@arm.com>
 <20171117114143.26577-2-steve.capper@arm.com>
 <20171120162521.gn37lrfwgw2aabv6@lakrids.cambridge.arm.com>
Message-ID: <20171121111559.ayzcp5jsiiemqy3m@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 04:25:22PM +0000, Mark Rutland wrote:
> On Fri, Nov 17, 2017 at 11:41:42AM +0000, Steve Capper wrote:
> > Currently one resolves the location of the reserved_ttbr0 for PAN by
> > taking a positive offset from swapper_pg_dir. In a future patch we wish
> > to extend the swapper s.t. its size is determined at link time rather
> > than comile time, rendering SWAPPER_DIR_SIZE unsuitable for such a low
> > level calculation.
> > 
> > In this patch we re-arrange the order of the linker script s.t. instead
> > one computes reserved_ttbr0 by subtracting RESERVED_TTBR0_SIZE from
> > swapper_pg_dir.
> > 
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> Looks sane to me. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-- 
Steve

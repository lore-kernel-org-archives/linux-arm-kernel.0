From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 15:13:54 +0100
Subject: [PATCH] arm64: pmuv3: handle pmuv3+
In-Reply-To: <20170425140538.GO24484@arm.com>
References: <1493118530-5314-1-git-send-email-mark.rutland@arm.com>
 <20170425140538.GO24484@arm.com>
Message-ID: <20170425141354.GE18225@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 03:05:39PM +0100, Will Deacon wrote:
> On Tue, Apr 25, 2017 at 12:08:50PM +0100, Mark Rutland wrote:
> > Commit f1b36dcb5c316c27 ("arm64: pmuv3: handle !PMUv3 when probing") is
> > a little too restrictive, and prevents the use of of backwards
> > compatible PMUv3 extenstions, which have a PMUver value other than 1.
> > 
> > For instance, ARMv8.1 PMU extensions (as implemented by ThunderX2) are
> > reported with PMUver value 4.
> > 
> > Per the usual ID register principles, at least 0x1-0x7 imply a
> > PMUv3-compatible PMU. It's not currently clear whether 0x8-0xe imply the
> > same.
> > 
> > For the time being, treat the value as signed, and with 0x1-0x7 treated
> > as meaning PMUv3 is implemented. This may be relaxed by future patches.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reported-by: Jayachandran C <jnair@caviumnetworks.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> > Will, would you be happy to queue this fixup for v4.12?
> 
> Catalin: please can you pick this up via arm64 with my Ack and
> Jayachandran's tested-by?

Done. Thanks.

-- 
Catalin

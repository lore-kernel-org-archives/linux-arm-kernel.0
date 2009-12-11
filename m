From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Dec 2009 09:36:05 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <SNT109-W5125384E245D2B1026CD6DA78D0@phx.gbl>
References: <SNT109-W5125384E245D2B1026CD6DA78D0@phx.gbl>
Message-ID: <1260524165.3109.3.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-10 at 18:45 +0000, mkl lin wrote:
> >> Good point, that's actually a quick modification (2-3 lines in each
> >> cache function). Mac Lin, can you try the patch below (without the other
> >> broadcasting patch)? If it works, I'll add some comment:
> > I have tested with my patch, and it seems good. No data integrity
> > issue, nor any deadlock.
> 
> BTW, read performance drops from 64MBps to 44MBps on my platform.

Is this compared to the IPI patch or to the UP (maxcpus=1) version?

You can try placing a "pld [r0, #32] before the new ldr/str so that it
fetches the next cache line while the loop is dealing with the current
one.

Thanks.

-- 
Catalin

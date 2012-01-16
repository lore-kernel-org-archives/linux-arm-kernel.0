From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 18:26:22 +0000
Subject: [PATCH 1/2] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <4F146AEA.90600@codeaurora.org>
References: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
 <4F146AEA.90600@codeaurora.org>
Message-ID: <20120116182622.GC11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jan 16, 2012 at 06:22:34PM +0000, Stephen Boyd wrote:
> On 01/16/12 07:44, Will Deacon wrote:
> > The linker script assumes a cacheline size of 32 bytes when aligning
> > the .data..cacheline_aligned and .data..percpu sections.
> >
> > This patch updates the script to use L1_CACHE_BYTES, which should be set
> > to 64 on platforms that require it.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >
> > v2: incorporated suggestions from Stephen Boyd
> 
> What do you think about aligning the exception fixup table to the same
> value?

Hmm, I'm not sure I see what that gains us over the current 32-byte
alignment. Are you seeing any measurable performance difference with it being
cacheline-aligned?

Will

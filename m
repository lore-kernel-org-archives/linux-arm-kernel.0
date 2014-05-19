From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 May 2014 12:01:13 +0100
Subject: [PATCH 1/1] arm64: TLB maintainance: Implement flush_kern_tlb_page
In-Reply-To: <CAD15agbbyEPbM5rw9gfAC5qMUxi-0rWp58J40j2XYYyf27rozQ@mail.gmail.com>
References: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
 <1400495665-48279-2-git-send-email-ritesh.harjani@gmail.com>
 <20140519104632.GI5113@arm.com>
 <CAD15agbbyEPbM5rw9gfAC5qMUxi-0rWp58J40j2XYYyf27rozQ@mail.gmail.com>
Message-ID: <20140519110113.GL5113@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:54:31AM +0100, Ritesh Harjani wrote:
> On Mon, May 19, 2014 at 4:16 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Mon, May 19, 2014 at 11:34:25AM +0100, ritesh.harjani at gmail.com wrote:
> >> From: Ritesh Harjani <ritesh.harjani@gmail.com>
> >>
> >> Implement flush_kern_tlb_page mentioned in the header
> >> comment of arch/arm64/include/asm/tlbflush.h
> >
> > Alternatively, clean-up the comment.
> 
> You mean this function is of no use ? Or there are other plans which
> might require clean up of this file ?

Since we don't have it and the kernel builds fine, I guess we don't need
it.

> Also, could you please confirm whether the implementation of the
> function is correct ?
> 
> >> +       asm("tlbi       vae1is, %0" : : "r" (addr));
> 
> Should following instruction be more appropriate instead of above:
> asm("tlbi       vaae1is, %0" : : "r" (addr));

You should use the vaae1is variant for all ASIDs since it's a global
mapping (see flush_tlb_kernel_range()).

-- 
Catalin

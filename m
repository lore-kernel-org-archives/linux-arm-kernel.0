From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Mar 2015 12:08:02 +0000
Subject: [PATCH 2/3] arm64: remove __calc_phys_offset
In-Reply-To: <CAKv+Gu9BcOP7LUgsguXV9KYJqk4iUNC_WhJhRHFFHgNmV3nFQQ@mail.gmail.com>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426587074-22390-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150317144625.GH23340@leverpostej>
 <CAKv+Gu9BcOP7LUgsguXV9KYJqk4iUNC_WhJhRHFFHgNmV3nFQQ@mail.gmail.com>
Message-ID: <20150318120802.GA19624@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> -     bl      __calc_phys_offset              // x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
> >> +     adrp    x24, KERNEL_START - TEXT_OFFSET // x24=PHYS_OFFSET
> >
> > Neat!
> >
> > Perhaps we could have:
> >
> > #define PHYS_OFFSET     (KERNEL_START - TEXT_OFFSET)
> >
> > Which would make the all the PHYS_OFFSET calculations self-documenting.
> > It shouldn't clash with the asm/memory.h definition because that's in an
> > #ifndef __ASSEMBLY__ block.
> >
> 
> I will use __PHYS_OFFSET instead, to prevent confusion.
> 
> Btw, I will drop the secondary 'adrp x24, __PHYS_OFFSET' lines
> completely, as the secondary boot path never refers to x24.

Sounds good to me on both counts.

Mark.

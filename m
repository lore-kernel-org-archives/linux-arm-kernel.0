From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Mar 2015 12:09:24 +0000
Subject: [PATCH 1/3] arm64: merge __enable_mmu and __turn_mmu_on
In-Reply-To: <CAKv+Gu8vCjLnyBAcEfucFAj7KqB3qmfKvjowNRoG1dWXoFjYsQ@mail.gmail.com>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426587074-22390-2-git-send-email-ard.biesheuvel@linaro.org>
 <550866E6.5050901@codeaurora.org>
 <CAKv+Gu8vCjLnyBAcEfucFAj7KqB3qmfKvjowNRoG1dWXoFjYsQ@mail.gmail.com>
Message-ID: <20150318120924.GB19624@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> - * Setup common bits before finally enabling the MMU. Essentially this is just
> >> - * loading the page table pointer and vector base registers.
> >> + * Enable the MMU. This completely changes the structure of the visible memory
> >> + * space. You will not be able to trace execution through this.
> >
> > I don't understand the last sentence. I recall being able to read and
> > eventually understand simulator instruction traces of this code. Is the
> > sentence referring to the Embedded Trace Macrocell or something?
> >
> 
> I guess the comment is a bit stale: it was inherited from the ARM
> version, where older platforms only have a single TTBR register, and
> switching address spaces is a bit more involved. On arm64, however,
> there are always two TTBR registers at EL1, and the address spaced
> they represent can never overlap, so there it isn't such a big deal.

Indeed. Feel free to drop it if you want.

Mark.

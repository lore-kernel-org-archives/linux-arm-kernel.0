From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jun 2018 11:28:15 +0200
Subject: [PATCH 5/5] x86/kernel: jump_table: use relative references
In-Reply-To: <CAKv+Gu9oxJCvpxRKpkndci1RGuewBsAPQW9W1=uXU1boGTSRrQ@mail.gmail.com>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-6-ard.biesheuvel@linaro.org>
 <20180628083107.GY2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu9oxJCvpxRKpkndci1RGuewBsAPQW9W1=uXU1boGTSRrQ@mail.gmail.com>
Message-ID: <20180628092815.GD2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 10:34:54AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 10:31, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Jun 27, 2018 at 06:06:04PM +0200, Ard Biesheuvel wrote:
> >> Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
> >> relative references rather than 64-bit absolute ones when emitting
> >> struct jump_entry instances. Not only does this reduce the memory
> >> footprint of the entries themselves by 50%, it also removes the need
> >> for carrying relocation metadata on relocatable builds (i.e., for KASLR)
> >> which saves a fair chunk of .init space as well (although the savings
> >> are not as dramatic as on arm64)
> >
> > This will conflict with:
> >
> >   https://lkml.kernel.org/r/20180622172212.199633-10-namit at vmware.com
> 
> Thanks for the head's up. Fortunately, it does not conflict
> fundamentally, so it should be a straight-forward rebase after that
> code is merged.

Yeah, shouldn't be hard to cure.

There's another patch set that might have a little conflict, but that's
not near ready I think, so that'll have to just cope with things
shifting underneath (and there too, the fixup shouldn't be hard).

> Do you think this is likely to get merged for v4.19?

I'm thinking it is near ready so it might, but I'm not in charge of
those bits :-)

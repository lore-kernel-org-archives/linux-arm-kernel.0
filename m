From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Jan 2016 11:23:07 +0000
Subject: [PATCH v3 07/21] arm64: move kernel image to base of vmalloc area
In-Reply-To: <CAKv+Gu-mPcXBTpENRaM5qo0nV_z93ZKw=5o5xVLNMU7QfiRCHQ@mail.gmail.com>
References: <1452518355-4606-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452518355-4606-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160112181336.GF4858@leverpostej>
 <CAKv+Gu-TS7w=AVBceGhsQkQzVCv+u7Gh6ojftwW1iaE+d0yrYw@mail.gmail.com>
 <20160113135109.GJ23370@leverpostej>
 <20160114185701.GA28181@leverpostej>
 <CAKv+Gu-mPcXBTpENRaM5qo0nV_z93ZKw=5o5xVLNMU7QfiRCHQ@mail.gmail.com>
Message-ID: <20160115112306.GC3262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 10:54:26AM +0100, Ard Biesheuvel wrote:
> On 14 January 2016 at 19:57, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 13, 2016 at 01:51:10PM +0000, Mark Rutland wrote:
> >> On Wed, Jan 13, 2016 at 09:39:41AM +0100, Ard Biesheuvel wrote:
> >> > If I remove the rounding, I get false positive kasan errors which I
> >> > have not quite diagnosed yet, but are probably due to the fact that
> >> > the rounding performed by vmemmap_populate() goes in the wrong
> >> > direction.
> >
> > As far as I can see, it implicitly rounds the base down and end up to
> > SWAPPER_BLOCK_SIZE granularity.
> >
> > I can see that it might map too much memory, but I can't see why that
> > should trigger KASAN failures. Regardless of what was mapped KASAN
> > should stick to the region it cares about, and everything else should
> > stay out of that.
> >
> > When do you see the failures, and are they in any way consistent?
> >
> > Do you have an example to hand?
> >
> 
> For some reason, this issue has evaporated, i.e., I can no longer
> reproduce it on my WIP v4 branch.
> So I will remove the rounding.

Ok.

I'll let you know if I stumble across anything that looks like a
potential cause of the KASAN failures, and I'll try to give v4 a go at
some point soon.

Thanks,
Mark.

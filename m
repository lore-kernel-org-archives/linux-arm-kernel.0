From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 15:38:04 +0100
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <1408113355.599.146.camel@deneb.redhat.com>
References: <CAKv+Gu_UjRNhhiM0GPsKRdXRtmEnY6cbpY-JZ33RUMapbPYsbQ@mail.gmail.com>
 <20140813125844.GE32644@leverpostej>
 <20140814171323.GH9039@arm.com>
 <CAKv+Gu9ftjZby+5U5Vs0hXhyFdNLwx4MwvC-LL=y3a9eSz34iQ@mail.gmail.com>
 <20140815115714.GP27466@arm.com>
 <CAKv+Gu-2RyWY4V7zoOQEi3As96kmmAMae2s3YauJ4bL9-h+sdg@mail.gmail.com>
 <20140815125324.GQ27466@arm.com>
 <CAKv+Gu9vj=b3pOJC3-x+QdjcErHShicEw-_6UHABG_j3qkGGOw@mail.gmail.com>
 <1408113355.599.146.camel@deneb.redhat.com>
Message-ID: <20140815143804.GW27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 03:35:55PM +0100, Mark Salter wrote:
> On Fri, 2014-08-15 at 15:28 +0200, Ard Biesheuvel wrote:
> > On 15 August 2014 14:53, Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Aug 15, 2014 at 01:07:16PM +0100, Ard Biesheuvel wrote:
> > >> On 15 August 2014 13:57, Will Deacon <will.deacon@arm.com> wrote:
> > >> > I was planning to take all of these for 3.18 as there's no regression here
> > >> > (the fuzzing is a new debug feature and defaults to `n'). Do you think these
> > >> > qualify as -rc1 material?
> > >> >
> > >>
> > >> Considering that TEXT_OFFSET fuzzing is recommended to be turned on
> > >> for distro kernels, I would say this is definitely appropriate for
> > >> 3.17
> > >
> > > Whilst I see that in the commit log, the same recommendation doesn't appear
> > > in the Kconfig text and I'm not sure that it's such a wise thing to say
> > > either. From a distribution's point of view, I think I'd want any kernel
> > > issues to be as reproducible as possible, and fuzzing the text offset seems
> > > to go against that.
> > >
> > 
> > OK. There is one other real world issue that 3/3 addresses, which are
> > platforms that have memreserves at the base of DRAM containing bits of
> > UEFI itself (this is what got this whole discussion going in the first
> > place). Currently, we cannot boot via UEFI on these platforms, as the
> > EFI stub will only consider base of DRAM + TEXT_OFFSET as an option,
> > and fail the boot if it is not available.
> > 
> > If this is something that could wait until 3.18 as well (Mark S?),
> > then it's fine by me.
> > 
> 
> I don't see a problem with waiting until 3.18.

Cheers, I've applied the series to our for-next branch and I'll push
everything out at -rc1.

Will

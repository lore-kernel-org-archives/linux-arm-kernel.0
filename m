From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:49:12 +0000
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <CAKwvOdnf4VS=3rQz2KUX68XLw2Dpv6oQp8EqDCDMXcKCmb3M8A@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <CAKwvOdkTSXuxiFVUPXmefnDM6uV3BLDEJ+suO0BgfZxC6+Srbw@mail.gmail.com>
 <20171103182901.eajkzkef3to4p6rf@lakrids.cambridge.arm.com>
 <CAKwvOdnf4VS=3rQz2KUX68XLw2Dpv6oQp8EqDCDMXcKCmb3M8A@mail.gmail.com>
Message-ID: <20171103184912.n4hoehrqqmf3ui44@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:36:33AM -0700, Nick Desaulniers wrote:
> On Fri, Nov 3, 2017 at 11:29 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Nov 03, 2017 at 11:07:04AM -0700, Nick Desaulniers wrote:
> >> On Fri, Nov 3, 2017 at 10:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > I had to create an aarch64-linux-gnu-clang wrapper, too. I'm not sure if
> >> > there's build system help to avoid needing that?
> >>
> >> Gah!  So a BIG difference with Clang vs GCC for cross compiling is
> >> that Clang by default ships with all backends enabled, and uses a
> >> `-target <triple>` CFLAG to determine the arch to cross compile for,
> >> while GCC is configured at compile time to support one back end, IIUC.
> >
> > Yup.
> >
> > I initally tried passing CC=clang\ --target=aarch64-linux-gnu
> >
> > ... but since that conflicts with CROSS_COMPILE, you then have to
> > override AS, LD, OBJCOPY, etc, separately too.
> 
> make CC=clang CROSS_COMPILE=aarch64-linux-gnu-
> 
> I think you may need a trailing hyphen on your target as it gets
> prefixed onto as and ld:
> 
> Makefile:
> 
>  348 # Make variables (CC, etc...)
>  349 AS    = $(CROSS_COMPILE)as
>  350 LD    = $(CROSS_COMPILE)ld

I thought CC=clang CROSS_COMPILE=foo- would result in foo-clang, but
evidently this is not the case.

I must've meseed up something else; sorry for the noise.

Thanks for correcting me; now I can go delete my wrapper. :)

Thanks,
Mark.

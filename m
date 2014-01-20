From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jan 2014 10:23:02 +0000
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <CALicx6tQu2O8o4pr-N8Xc=D-Y9kOMsFNsn6BLVDqRo0Pbay00Q@mail.gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <20140116134550.GA7496@arm.com>
 <CALicx6tQu2O8o4pr-N8Xc=D-Y9kOMsFNsn6BLVDqRo0Pbay00Q@mail.gmail.com>
Message-ID: <20140120102302.GC16496@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 08:02:21AM +0000, Vijay Kilari wrote:
> Hi Catalin,
> 
> On Thu, Jan 16, 2014 at 7:15 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Dec 19, 2013 at 11:50:48AM +0000, vijay.kilari at gmail.com wrote:
> >> Vijaya Kumar K (3):
> >>   AArch64: KGDB: Add Basic KGDB support
> >>   AArch64: KGDB: Add step debugging support
> >>   KGDB: make kgdb_breakpoint() as noinline
> >
> > I gave them a try and now I have some doubts about your testing
> > methodology:
> >
> > 1. There is no HAVE_ARCH_KGDB anywhere in these patches, so
> > the code here isn't compiled.
> >
> OK, I will send a patch
> 
> > 2. There are several compiler warnings that need to be addressed.
> >
> > 3. I enabled CONFIG_KGDB_TESTS and CONFIG_KGDB_TESTS_ON_BOOT and that's
> > what really scared me.
> >
> 
> Are you refering to these warning?. I don't see any warning in the
> patched files. I will fix these.

[...]

Well, the warnings are one thing but the 100 miles of backtrace output that
appear on every boot (and I think end in an oops) are probably more
important to fix. Please enable CONFIG_KGDB_TESTS and
CONFIG_KGDB_TESTS_ON_BOOT and take a look.

Will

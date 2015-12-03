From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 17:17:31 +0000
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151202002430.GB23156@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <2776283.xtmDQm6BqS@wuerfel> <87zixue8lj.fsf@igel.home>
 <1608639.5Yic1PH469@wuerfel> <20151202002430.GB23156@yury-N73SV>
Message-ID: <20151203171730.GN10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 03:24:30AM +0300, Yury Norov wrote:
> On Tue, Dec 01, 2015 at 12:30:56PM +0100, Arnd Bergmann wrote:
> > On Tuesday 01 December 2015 12:01:12 Andreas Schwab wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > 
> > > > On Tuesday 01 December 2015 10:20:59 Andreas Schwab wrote:
> > > >> Yury Norov <ynorov@caviumnetworks.com> writes:
> > > >> 
> > > >> > There's a tricky bug with signal stack, that Andreas also discovered.
> > > >> 
> > > >> That was only a confusion about the compat state of sys_rt_sigaction.
> > > >> It just requires making sure glibc uses the correct (64bit layout)
> > > >> struct kernel_sigaction.
> > > >
> > > > I don't think we need to use the 64-bit version of sigaction, both
> > > > kernel and libc are simpler if we use the normal 32-bit version.
> > > 
> > > Since glibc has to do the conversion anyway (due to sigset_t), using the
> > > 64bit layout avoids a second conversion in the kernel.
> > 
> > I don't get the part about sigset_t. Why would glibc want to use the
> > 64-bit layout? This one looks like one of the cases where we absolutely
> > want to use the 32-bit layout or otherwise get into big trouble if
> > we ever want to support native ILP32 kernels.
> > 
> > 	Arnd
> 
> So, we drop patch #6, and use 32-bit layout for all signal structures.
> 
> Correct?

I would vote for this as well. I think it probably removes patch 12 as
well (COMPAT_USE_NATIVE_SIGINFO).

-- 
Catalin

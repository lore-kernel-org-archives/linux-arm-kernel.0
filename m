From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 12:30:56 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <87zixue8lj.fsf@igel.home>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <2776283.xtmDQm6BqS@wuerfel> <87zixue8lj.fsf@igel.home>
Message-ID: <1608639.5Yic1PH469@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 12:01:12 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Tuesday 01 December 2015 10:20:59 Andreas Schwab wrote:
> >> Yury Norov <ynorov@caviumnetworks.com> writes:
> >> 
> >> > There's a tricky bug with signal stack, that Andreas also discovered.
> >> 
> >> That was only a confusion about the compat state of sys_rt_sigaction.
> >> It just requires making sure glibc uses the correct (64bit layout)
> >> struct kernel_sigaction.
> >
> > I don't think we need to use the 64-bit version of sigaction, both
> > kernel and libc are simpler if we use the normal 32-bit version.
> 
> Since glibc has to do the conversion anyway (due to sigset_t), using the
> 64bit layout avoids a second conversion in the kernel.

I don't get the part about sigset_t. Why would glibc want to use the
64-bit layout? This one looks like one of the cases where we absolutely
want to use the 32-bit layout or otherwise get into big trouble if
we ever want to support native ILP32 kernels.

	Arnd

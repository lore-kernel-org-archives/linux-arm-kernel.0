From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Aug 2010 22:05:39 +0100
Subject: [PATCH] wire up sys_accept4() on ARM
In-Reply-To: <19557.7592.825768.377190@pilspetsen.it.uu.se>
References: <19544.10902.127940.970133@pilspetsen.it.uu.se>
	<19557.7592.825768.377190@pilspetsen.it.uu.se>
Message-ID: <20100814210539.GC1999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 12:25:44PM +0200, Mikael Pettersson wrote:
> Mikael Pettersson writes:
>  > sys_accept4() was added in kernel 2.6.28, but ARM was not updated
>  > to include it.  The number and types of parameters is such that
>  > no ARM-specific processing is needed, so wiring up sys_accept4()
>  > just requires defining __NR_accept4 and adding a direct call in
>  > the syscall entry table.
>  > 
>  > Tested with an EABI 2.6.35 kernel and Ulrich Drepper's original
>  > accept4() test program, modified to define __NR_accept4 for ARM.
>  > 
>  > Using the updated unistd.h also eliminates a warning then building
>  > glibc (2.10.2 and newer) about accept4() being unimplemented.
>  > 
>  > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> Ping.  Ok for patch system?

Yup.

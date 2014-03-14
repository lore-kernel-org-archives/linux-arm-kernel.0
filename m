From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 14 Mar 2014 09:42:10 +0000
Subject: [PATCH v4] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>
References: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140314094209.GA27302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 01:19:29PM -0500, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).
> 
> Clocks supported:
> - CLOCK_REALTIME
> - CLOCK_MONOTONIC
> - CLOCK_REALTIME_COARSE
> - CLOCK_MONOTONIC_COARSE
> 
> This also provides clock_getres (as arm64 does).
> 
> Note that while the high-precision realtime and monotonic clock
> support depends on the generic timers extension, support for
> clock_getres and coarse clocks is independent of the timer
> implementation and is provided unconditionally.
> 
> Run-time tested on OMAP5, Arndale, and i.MX6 using a patched glibc[1],
> verifying that results from the vDSO are consistent with results from
> the kernel.
> 
> [1] RFC glibc patch here:
> https://www.sourceware.org/ml/libc-alpha/2014-02/msg00680.html
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> Tested-by: Steve Capper <steve.capper@linaro.org>
> ---
> 
> Steve, since I made some minor changes from v3, re-testing on your
> Arndale would be very much appreciated and would keep the changelog
> technically honest :-)

Hi Nathan,
Sure :-), I've given this another go on an Arndale (running 3.14-rc6
with LPAE enabled). Everything that worked before works now too. Also,
I've tested the /0 and this gave the SIGILL as expected; and putting
gettimeofday in a big loop made it appear as [vdso] code in perf.

So I'm happy to keep the Tested-by on this.

Cheers,
-- 
Steve

From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 5 Sep 2014 21:32:49 -0500
Subject: [PATCH v9 0/6] ARM: VDSO
In-Reply-To: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <540A7251.8050708@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2014 04:52 PM, Nathan Lynch wrote:
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
> getcpu support is planned but not included at this time.
> 
> For applications to transparently benefit from this change,
> ARM-specific support code needs to be added to glibc.  I have such a
> patch, and have verified that glibc's self tests do not detect any
> regressions.  I hope to have that code added to glibc for the 2.21
> release.
> 
> The VDSO symbols are available for lookup via dlsym even with an
> unpatched glibc.
> 
> Note that while the high-precision realtime and monotonic clock
> support depends on the generic timers extension, support for
> clock_getres and coarse clocks is independent of the timer
> implementation and is provided unconditionally.  High-resolution clock
> support requires changes to the arch timer code, posted here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/281280.html
> 
> The VDSO will function correctly without those changes, but
> gettimeofday and clock_gettime with CLOCK_REALTIME/CLOCK_MONOTONIC
> will not be accelerated.

Russell, what is your current thinking on taking the VDSO patches?  I
believe all feedback has been addressed and I was hoping to get it into
3.18...

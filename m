From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 1 Jul 2014 11:34:25 -0500
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <CAKv+Gu87_5Fx=z6Kg3EBi7YTm+f9DpiaZVw_UU9xKZD1MoJW8w@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <CAKv+Gu87_5Fx=z6Kg3EBi7YTm+f9DpiaZVw_UU9xKZD1MoJW8w@mail.gmail.com>
Message-ID: <53B2E311.6030609@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 03:12 AM, Ard Biesheuvel wrote:
> On 23 June 2014 05:11, Nathan Lynch <nathan_lynch@mentor.com> wrote:
>> Provide fast userspace implementations of gettimeofday and
>> clock_gettime on systems that implement the generic timers extension
>> defined in ARMv7.

...

> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> On Exynos-5250 (Cortex-A15):
> 
> clock-gettime-monotonic system calls per second: 1759517
> clock-gettime-monotonic vdso calls per second:   6027915 (3.43x speedup)
> clock-getres-monotonic system calls per second: 2144055
> clock-getres-monotonic vdso calls per second:   82783103 (38.61x speedup)
> clock-gettime-monotonic-coarse system calls per second: 1971433
> clock-gettime-monotonic-coarse vdso calls per second:   10710734 (5.43x speedup)
> clock-getres-monotonic-coarse system calls per second: 2182380
> clock-getres-monotonic-coarse vdso calls per second:   76710594 (35.15x speedup)
> clock-gettime-realtime system calls per second: 1722524
> clock-gettime-realtime vdso calls per second:   6309212 (3.66x speedup)
> clock-getres-realtime system calls per second: 2182357
> clock-getres-realtime vdso calls per second:   83120713 (38.09x speedup)
> clock-gettime-realtime-coarse system calls per second: 2085498
> clock-gettime-realtime-coarse vdso calls per second:   11326069 (5.43x speedup)
> clock-getres-realtime-coarse system calls per second: 2178266
> clock-getres-realtime-coarse vdso calls per second:   76731175 (35.23x speedup)
> Note: vDSO version of getcpu not found
> getcpu system calls per second: 2645300
> getcpu vdso calls per second:   2612154 (0.99x speedup)
> Note: vDSO version of getcpu not found
> Note: vDSO version of getcpu not found
> gettimeofday system calls per second: 1707745
> gettimeofday vdso calls per second:   6474501 (3.79x speedup)

Thank you very much for testing (especially on a platform I don't have).

These results match up with what I get on OMAP5 (also Cortex-A15).

Since it looks like I will need to make some significant changes for the
next version, I think I can't in good conscience carry your Tested-by on
to v8 (although I'm open to different opinions).  But I still very much
appreciate it.

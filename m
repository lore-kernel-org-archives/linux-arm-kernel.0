From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Nov 2013 14:58:07 +0100
Subject: [PATCH RFC 2/6] arm64: Kprobes with single stepping support
In-Reply-To: <20131111105812.GC28302@mudshark.cambridge.arm.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-3-git-send-email-sandeepa.prabhu@linaro.org>
 <20131108165639.GD15074@mudshark.cambridge.arm.com>
 <527DFC1C.1020107@hitachi.com>
 <CA+b37P3U=cAbUvs=2B9wA4F7S9o49vh7d-KamjPsHcz-b9ZYLA@mail.gmail.com>
 <52808D53.7080904@hitachi.com> <5280B6C8.7050807@hitachi.com>
 <20131111105812.GC28302@mudshark.cambridge.arm.com>
Message-ID: <20131113135807.GJ26898@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 10:58:12AM +0000, Will Deacon wrote:
> Single-stepping on x86 is different to the step behaviour on arm64 afaik. On
> ARM, we have to manually remove the breakpoint, perform a single-step, then
> add the breakpoint again. If we re-enable debug exceptions in the kprobe
> handler, the step will complete early and we'll never step off the
> breakpoint.

This is about hardware breakpoints right? Which are per-cpu? Otherwise
removing the breakpoint would open up a hole for another thread to slip
through while you're single stepping.

From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 11 Dec 2015 17:34:41 +0800
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <566A5997.9020908@linaro.org>
References: <566A5997.9020908@linaro.org>
Message-ID: <CAPvkgC3q6J7tryN24jCW4AZvsAQ=TseSuZnxF+8bF7UMX9Yb5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 13:05, David Long <dave.long@linaro.org> wrote:
> There is a moderate amount of code already in kprobes on ARM and the current
> ARMv8 patch to deal with conditional execution of instructions. One aspect
> of how this is handled is that instructions that fail their predicate and
> are not (technically) executed are also not treated as a hit kprobe. Steve
> Capper has suggested that the probe handling should still take place because
> we stepped through the instruction even if it was effectively a nop.  This
> would be a significant change in how it currently works on 32-bit ARM, and a
> change in the patch for ARMv8 (although it's not likely to be much of a
> change in the kernel code).
>
> I need input on this.  Do people have opinions?

Hi David,
Thanks for posting this.

Just to clarify the reasoning behind my suggestion for kprobes always
being hit was to achieve parity with x86.

I highlighted an example of discrepancy in behaviour between arm64 and
x86 in the following email:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364201.html

Cheers,
--
Steve

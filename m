From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jul 2016 15:17:49 +0100
Subject: [PATCH v15 01/10] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API
 feature
In-Reply-To: <57892286.1040609@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-2-git-send-email-dave.long@linaro.org>
 <20160715105701.GB14792@e104818-lin.cambridge.arm.com>
 <5788F86B.60305@linaro.org> <20160715150532.GA22563@localhost>
 <57892286.1040609@linaro.org>
Message-ID: <20160719141749.GC21256@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 01:51:02PM -0400, David Long wrote:
> On 07/15/2016 11:13 AM, Catalin Marinas wrote:
> >On Fri, Jul 15, 2016 at 10:51:23AM -0400, David Long wrote:
> >>On 07/15/2016 06:57 AM, Catalin Marinas wrote:
> >>>On Fri, Jul 08, 2016 at 12:35:45PM -0400, David Long wrote:
> >>>>+extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
> >>>
> >>>This one only seems to be used in arch/arm64/kernel/ptrace.c. Can we
> >>>make it static and remove the declaration?
> >>
> >>OK.
> >
> >I can change it locally.
> 
> It's looking like there will need to be another iteration of the patch for a
> few small things anyway, although those changes could also be done as
> subsequent improvements.

I've pushed the branch below with my fixups on this series. Please post
any minor changes you have as additional patches on top. Thanks.

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/kprobes

-- 
Catalin

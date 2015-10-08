From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 8 Oct 2015 23:45:01 +0900
Subject: [PATCH v3 0/7] arm64: ftrace: fix incorrect output from stack
 tracer
In-Reply-To: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <36B8D79C-E3BD-4937-94D1-B9725CA4FD68@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 8, 2015, at 7:01 PM, AKASHI Takahiro wrote:

Hi Akashi,

> This is the third patch series for fixing stack tracer on arm64.
> The original issue was reported by Jungseok[1], and then I found more
> issues[2].
> (Steven, Jungseok, sorry for not replying to your comments directly.)
> 
> I address here all the issues and implement fixes described in [2] except
> for interrupt-triggered problems, ie. II-3). Recent discussions[3] about
> introducing a dedicated interrupt stack suggests that we may avoid walking
> through from an interrupt stack to a process stack.
> (So interrupt-stack patch is a prerequisite.)
> 
> Basically,
> patch1 corresponds to the original issue.
> patch2 is a proactive improvement of function_graph tracer. 
> patch3 corresponds to II-4(functions under function_graph tracer).
> patch4 corresponds to II-5(leaf function).
> patch5, 6 and 7 correspond to II-1(slurping stack) and II-2(differences
> between x86 and arm64).
> 
> Each fix can be applied independently, but if patch5, 6 and 7 are
> acceptable, patch1 is not necessary because patch7 replaces a default
> stack tracer.
> 
> I tested the code with v4.3-rc3 + Jungseok's patch v3[4].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html 
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368003.html
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371451.html

The [4] is not a valid patch. I hope the test has been going with the following one.

	http://www.kernelhub.org/?msg=841034&p=2

I will leave comments after playing with this series on top of my IRQ stack tree.

Best Regards
Jungseok Lee

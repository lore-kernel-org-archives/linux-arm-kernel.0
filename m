From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Oct 2015 15:23:45 +0000
Subject: [PATCH v3 0/7] arm64: ftrace: fix incorrect output from stack
 tracer
In-Reply-To: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151028152344.GG18966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 07:01:37PM +0900, AKASHI Takahiro wrote:
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

Given the comments and kbuild robot build errors, do you plan to post a
new version of this series?

Will

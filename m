From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Oct 2015 11:16:19 +0000
Subject: [PATCH v4 1/6] arm64: ftrace: adjust callsite addresses examined
 by stack tracer
In-Reply-To: <1446182741-31019-2-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
 <1446182741-31019-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151030111618.GA20030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 02:25:36PM +0900, AKASHI Takahiro wrote:
> On arm64, no PC values returned by save_stack_trace() will match to LR
> values saved in stack frames on a stack after the following commit:
>     commit e306dfd06fcb ("ARM64: unwind: Fix PC calculation")
> As a result, the output from stack tracer will be messed up.

FWIW, we've decided to revert that patch for the moment. We're the only
architecture making that kind of adjustment, so we should fix that before
building on top of it.

Will

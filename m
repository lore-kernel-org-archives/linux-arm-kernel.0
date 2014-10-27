From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 13:37:16 -0700
Subject: [PATCHv2 2/9] arm: perf: add missing pr_info newlines
In-Reply-To: <1414411599-1938-3-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-3-git-send-email-mark.rutland@arm.com>
Message-ID: <544EACFC.3090808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> Most of the pr_info format strings in perf_event_cpu.c are missing
> newlines. Currently we get away with this as the format strings for
> subsequent calls to printk (including all pr_* calls) begin with a log
> prefix, and the printk core adds the omitted newline for this case.
> While generates the output we expect, we probably should not rely on the
> format of successive printk calls in order to get legible output.
>
> This patch adds the missing newlines to pr_info format strings in
> perf_event_cpu.c, making them consistent with the format strings for
> other pr_info, warn, and pr_err calls, and preventing potentially
> illegible output if the next printk/pr_* format string doesn't begin
> with a log prefix.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

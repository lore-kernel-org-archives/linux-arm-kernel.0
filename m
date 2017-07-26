From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Jul 2017 14:38:17 -0700
Subject: [PATCHv2 3/7] arm64: move non-entry code out of .entry.text
In-Reply-To: <1501093110-3844-4-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-4-git-send-email-mark.rutland@arm.com>
Message-ID: <c35db9f2-6a4c-c85b-f01a-a4123d755a6e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2017 11:18 AM, Mark Rutland wrote:
> Currently, cpu_switch_to and ret_from_fork both live in .entry.text,
> though neither form the critical path for an exception entry.
>
> In subsequent patches, we will require that code in .entry.text is part
> of the critical path for exception entry, for which we can assume
> certain properties (e.g. the presence of exception regs on the stack).
>
> Neither cpu_switch_to nor ret_from_fork will meet these requirements, so
> we must most them out of .entry.text. To ensure that neither are kprobed

s/most/move/ ?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

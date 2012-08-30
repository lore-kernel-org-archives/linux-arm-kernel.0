From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Aug 2012 16:51:13 -0700
Subject: [PATCH v2 1/2] ARM: delay: set loops_per_jiffy when moving to
 timer-based loop
In-Reply-To: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
Message-ID: <503FFC71.1070506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2012 2:25 PM, Will Deacon wrote:
> The delay functions may be called by some platforms between switching to
> the timer-based delay loop but before calibration. In this case, the
> initial loops_per_jiffy may not be suitable for the timer (although a
> compromise may be achievable) and delay times may be considered too
> inaccurate.
>
> This patch updates loops_per_jiffy when switching to the timer-based
> delay loop so that delays are consistent prior to calibration.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

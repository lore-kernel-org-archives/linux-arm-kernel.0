From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 02 Jul 2012 12:14:57 -0700
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <1340991231-17682-3-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
Message-ID: <4FF1F331.3000001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/12 10:33, Will Deacon wrote:
> This patch allows a timer-based delay implementation to be selected by
> switching the delay routines over to use get_cycles, which is
> implemented in terms of read_current_timer. This further allows us to
> skip the loop calibration and have a consistent delay function in the
> face of core frequency scaling.
>
> To avoid the pain of dealing with memory-mapped counters, this
> implementation uses the co-processor interface to the architected timers
> when they are available. The previous loop-based implementation is
> kept around for CPUs without the architected timers and we retain both
> the maximum delay (2ms) and the corresponding conversion factors for
> determining the number of loops required for a given interval. Since the
> indirection of the timer routines will only work when called from C,
> the sa1100 sleep routines are modified to branch to the loop-based delay
> functions directly.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

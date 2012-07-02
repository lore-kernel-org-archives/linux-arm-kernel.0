From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 02 Jul 2012 12:14:55 -0700
Subject: [PATCH v2 1/2] ARM: arch timer: implement read_current_timer
 and get_cycles
In-Reply-To: <1340991231-17682-2-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-2-git-send-email-will.deacon@arm.com>
Message-ID: <4FF1F32F.9060609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/12 10:33, Will Deacon wrote:
> This patch implements read_current_timer using the architected timers
> when they are selected via CONFIG_ARM_ARCH_TIMER. If they are detected
> not to be usable at runtime, we return -ENXIO to the caller.
>
> Furthermore, if read_current_timer is exported then we can implement
> get_cycles in terms of it for use as both an entropy source and for
> implementing __udelay and friends.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

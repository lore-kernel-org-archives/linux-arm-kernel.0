From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 17 Jul 2012 12:41:01 -0400
Subject: [RFC PATCH 1/4] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1341566422-20368-2-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
 <1341566422-20368-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <5005959D.3050407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Here's one additional small question about your explanation in the
commit message.

On 07/06/2012 05:20 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.

If the virtual timer is "always available", why would a device tree
description of the hardware leave that interrupt number out as described
below?

> This patch enables the use of both the virtual timer, unless no
> interrupt is provided in the DT for it, in which case is falls
> back to the physical timer.

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

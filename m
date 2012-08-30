From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Aug 2012 16:28:08 -0700
Subject: [PATCH v3 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1345819976-6339-2-git-send-email-marc.zyngier@arm.com>
References: <1345819976-6339-1-git-send-email-marc.zyngier@arm.com>
 <1345819976-6339-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <503FF708.10603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/24/2012 7:52 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
>
> This patch enables the use of the virtual timer, unless no
> interrupt is provided in the DT for it, in which case it falls
> back to the physical timer.

Is this a good candidate for static keys? It looks like we make the
decision fairly early and then we're done and have a bunch of if
statements. Maybe its premature optimization though...

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

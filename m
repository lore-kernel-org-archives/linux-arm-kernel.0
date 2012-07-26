From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 26 Jul 2012 15:19:50 -0400
Subject: [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <50119856.2020206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 07/26/2012 11:33 AM, Stefano Stabellini wrote:
> Use r12 to pass the hypercall number to the hypervisor.
> 
> We need a register to pass the hypercall number because we might not
> know it at compile time and HVC only takes an immediate argument.

You're not going to JIT assemble the appropriate HVC instruction? Darn.

How many call numbers are there, though? 8? It seems like it'd be
reasonable to take the approach that seems to be favored for MRC/MCR
instructions, using a function containing switch statement that chooses
between several inline assembly instructions based off an enum passed to
the function. See for example arch_timer_reg_read in
arch/arm/kernel/arch_timer.c.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Jan 2013 13:13:44 +0000
Subject: [PATCH] ARM: arch_timer: Don't expect both secure and nonsecure
 PPI IRQ info
In-Reply-To: <1358511830-7909-1-git-send-email-rnayak@ti.com>
References: <1358511830-7909-1-git-send-email-rnayak@ti.com>
Message-ID: <50F94A88.1070209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/13 12:23, Rajendra Nayak wrote:

Hi Rajendra,

> The current logic expects platforms to pass information about *both*
> secure and nonsecure PPI IRQ. Make arch_timer work even when either one
> of those are provided instead.

I'm afraid this patch doesn't really solve the problem. The DT binding
cannot express having only the virtual interrupt, or only the non-secure
physical interrupt. This patch only works in the case where you only
have the secure physical interrupt.

I think the real fix should be to make all the interrupts mandatory in
the DT (they do exist in the HW), and make the code less tolerant of
broken DTs.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...

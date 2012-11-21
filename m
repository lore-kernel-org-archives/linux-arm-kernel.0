From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:38:50 +0000
Subject: [PATCH V5 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
References: <1353446150-10088-1-git-send-email-gregory.clement@free-electrons.com>
 <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121121113850.GZ3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 10:15:49PM +0100, Gregory CLEMENT wrote:
> +ENTRY(armada_xp_secondary_startup)
> +
> +	/* Read CPU id */
> + 	mrc     p15, 0, r1, c0, c0, 5
> +	and     r1, r1, #0xF
> +
> +	/* Add CPU to coherency fabric */
> +	ldr     r0, = ARMADA_XP_CFB_BASE
> +	mov	lr, pc
> +
> +	b	ll_set_cpu_coherent
> +	b	secondary_startup

This looks odd.  Why are you doing a mov lr,pc followed by a plain branch?
What's wrong with 'bl' here ?

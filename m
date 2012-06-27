From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 27 Jun 2012 17:11:19 +0100
Subject: [PATCH v5 4/9] arm: mach-mvebu: add support for Armada 370 and
 Armada XP with DT
In-Reply-To: <1340805290-9051-5-git-send-email-gregory.clement@free-electrons.com>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340805290-9051-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <4FEB30A7.3000809@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/12 14:54, Gregory Clement wrote:
> [ben.dooks at codethink.co.uk: ensure error check on of_property_read_u32]
> [ben.dooks at codethink.co.uk: use mpic address instead of bus-unit's ]
> [ben.dooks at codethink.co.uk: BUG_ON() if the of_iomap() fails for mpic]
> [ben.dooks at codethink.co.uk: move mpic per-cpu register base ]
> [ben.dooks at codethink.co.uk: number fetch should use irqd_to_hwirq()]
>
> Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem<alior@marvell.com>
> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>

[snip]

> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index f0eaa21..1b1e679 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -17,4 +17,7 @@
>
>   void mvebu_restart(char mode, const char *cmd);

If you set it when you probed the device, you'd not need
to export it in the header.

> +void armada_370_xp_init_irq(void);
> +asmlinkage void  armada_370_xp_handle_irq(struct pt_regs *regs);

You shouldn't need linkage info with a function declaration.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

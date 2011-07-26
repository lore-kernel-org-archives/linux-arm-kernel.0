From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 26 Jul 2011 17:35:50 +0300
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <1311295758-27493-1-git-send-email-simon@sequanux.org>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
	<1311295758-27493-1-git-send-email-simon@sequanux.org>
Message-ID: <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 3:49 AM, Simon Guinot <simon@sequanux.org> wrote:
> From: Simon Guinot <sguinot@lacie.com>
>
> This fixes a regression introduced by e59347a
> "arm: orion: Use generic irq chip".
>
> The same interrupt mask cache (stored within struct irq_chip_generic)
> is shared between all the irq_chip_type instances. As each irq_chip_type
> can use a distinct mask register, share a single mask cache is not
> correct. This bug affects Orion SoCs, which have separate mask registers
> for edge and level interrupts.
>
> This patch move mask_cache from struct irq_chip_generic into struct
> irq_chip_type. Note that the interrupt support for Samsung SoCs is also
> slightly affected.
The patch looks to fix the issue with orion, but it seems that it
won't work for SoC with multiple irq_chip_type that use one mask
register.

saeed

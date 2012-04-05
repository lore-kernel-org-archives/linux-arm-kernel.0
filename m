From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Apr 2012 17:47:58 -0700
Subject: [PATCH v2] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333579684-31466-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <1333579684-31466-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120405004757.GC10780@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [120404 15:51]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> broken. PCMCIA depends on __io() returning a valid i/o address, and most
> ARM platforms require IO_SPACE_LIMIT be set to 0xffffffff for PCMCIA. This
> needs a better fix with a fixed i/o address mapping, but for now we just
> restore things to the previous behavior.
> 
> This fixes at91, omap1, pxa and sa11xx. pxa needs io.h if PCI is enabled,
> but PCMCIA is not. sa11xx already has IO_SPACE_LIMIT set to 0xffffffff,
> so it doesn't need an io.h.

Acked-by: Tony Lindgren <tony@atomide.com>

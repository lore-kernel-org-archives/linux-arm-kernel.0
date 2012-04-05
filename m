From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 5 Apr 2012 12:10:53 +0200
Subject: [PATCH v2] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333579684-31466-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <1333579684-31466-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAGhQ9Vw3RfGWU6MLAq_duc_hg7t0Lps+L0rxVUdNek2y-7c7BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 12:48 AM, Rob Herring <robherring2@gmail.com> wrote:
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
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Joachim Eastwood <joachim.eastwood@jotron.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tony Lindgren <tony@atomide.com>

Works for me on AT91RM9200 using at91_cf and pata_pcmcia.

Tested-by: Joachim Eastwood <joachim.eastwood@jotron.com>


>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

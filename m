From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Apr 2012 11:29:06 -0700
Subject: [PATCH v2] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333579684-31466-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <1333579684-31466-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120405182906.GA29262@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 05:48:04PM -0500, Rob Herring wrote:
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

Thanks, applied to fixes.


-Olof

From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  2 Oct 2011 16:56:59 +0800
Subject: [PATCH 0/2] Make IPI and localtimer handlers callable from C code
Message-ID: <1317545821-23194-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Sorry for send you twice, Russell, Marc.  I forgot cc LAKML last time.]

With imx sub-architecture is moving to MULTI_IRQ_HANDLER, imx6q has to
get a local gic_handler_irq() implementation calling IPI and localtimer
handlers from C code, before Marc's global gic_handler_irq() series gets
merged.

This patch series changes the original __exception_irq_entry to a
wrapper for actual IPI and localtimer handlers which are callable from
C code now.

Marc Zyngier (1):
     ARM: smp: Add an IPI handler callable from C code

Shawn Guo (1):
     ARM: smp: Add a localtimer handler callable from C code

 arch/arm/include/asm/localtimer.h |    4 ++++
 arch/arm/include/asm/smp.h        |    5 +++++
 arch/arm/kernel/smp.c             |   10 ++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

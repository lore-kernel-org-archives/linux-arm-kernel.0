From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Jul 2011 16:31:34 -0600
Subject: [PATCH v2 0/2] Simple irq_domain implementation
Message-ID: <20110718222610.1911.5673.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Not much has changed with this second posting other than it shouldn't
break devicetree MIPS and Microblaze platforms anymore.  I've not had
the time to adapt irq_domain and powerpc to work together, but those a
changes that can easily be handled in follow-on patches.

Thomas, though this is not in its final form, I think it would be good
to merge it now since I've got several ARM device tree board ports
ready for v3.1 that depend on at least this basic implementation.
When I rework to get it in line with PowerPC, I'll also take care of
any changes needed by ARM and other users.

If you agree and provide an Ack, then I think these changes should go
in via devicetree/next since there are patches in there that this
patch depends on.

g.

---

Grant Likely (2):
      irq: add irq_domain translation infrastructure
      dt/irq: add irq_domain_generate_simple() helper


 arch/arm/include/asm/prom.h           |    5 -
 arch/arm/kernel/devtree.c             |   14 --
 arch/microblaze/include/asm/irq.h     |   10 --
 arch/microblaze/kernel/irq.c          |    7 -
 arch/mips/include/asm/irq.h           |    5 -
 arch/mips/kernel/prom.c               |   14 --
 arch/powerpc/include/asm/irq.h        |    1 
 arch/x86/include/asm/irq_controller.h |   12 --
 arch/x86/include/asm/prom.h           |   10 --
 arch/x86/kernel/devicetree.c          |  101 +++++-----------
 include/linux/irq.h                   |   92 ++++++++++++++
 include/linux/of_irq.h                |    2 
 kernel/irq/Makefile                   |    2 
 kernel/irq/irqdomain.c                |  215 +++++++++++++++++++++++++++++++++
 14 files changed, 346 insertions(+), 144 deletions(-)
 delete mode 100644 arch/x86/include/asm/irq_controller.h
 create mode 100644 kernel/irq/irqdomain.c

-- 
Signature

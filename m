From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 16:38:36 -0500
Subject: [GIT PULL] GIC DT binding support
Message-ID: <4EA5DADC.7030805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

I'm not sure if you want a rebased branch to fix merge conflicts or not.
If that's okay, please pull. I've also fixed the msm compile failure.

The dependencies are v3.1-rc9 and rmk's devel-stable.

The following changes since commit 3a8254364277fabe01bc0e12b9691722939f5ef3:

  Merge remote-tracking branch 'rmk/devel-stable' into HEAD (2011-10-24
14:02:37 -0500)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git gic-dt

Rob Herring (5):
      of/irq: introduce of_irq_init
      irq: support domains with non-zero hwirq base
      ARM: gic: add irq_domain support
      ARM: gic: add OF based initialization
      ARM: gic: fix irq_alloc_descs handling for sparse irq

 Documentation/devicetree/bindings/arm/gic.txt |   55 +++++++
 arch/arm/common/Kconfig                       |    1 +
 arch/arm/common/gic.c                         |  187
++++++++++++++++---------
 arch/arm/include/asm/hardware/gic.h           |   10 +-
 drivers/of/irq.c                              |  107 ++++++++++++++
 include/linux/irqdomain.h                     |   16 ++-
 include/linux/of_irq.h                        |    3 +
 kernel/irq/irqdomain.c                        |   12 +-
 8 files changed, 319 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

Rob

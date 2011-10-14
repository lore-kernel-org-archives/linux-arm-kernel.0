From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Oct 2011 22:01:21 -0500
Subject: [GIT PULL] GIC DT binding support
Message-ID: <4E97A601.1020005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull GIC device tree support. This is the first of 2 pull
requests. You can ignore this one if there are no other dependencies on
GIC DT support.

This is based on rmk's for-next branch and v3.1-rc9. rc9 was needed for
this dependency:

commit eef24afb28561a5a9f4be8f8da97735b7e6a826f
irq: Fix check for already initialized irq_domain in irq_domain_add

Regards,
Rob

The following changes since commit dd5e9eb0d051606ee3eda0c30222429c74e23f00:

  Merge commit 'v3.1-rc9' into upstream/base (2011-10-13 20:30:42 -0500)

are available in the git repository at:

  http://sources.calxeda.com/git/kernel/linux.git gic-dt

Rob Herring (4):
      of/irq: introduce of_irq_init
      irq: support domains with non-zero hwirq base
      ARM: gic: add irq_domain support
      ARM: gic: add OF based initialization

 Documentation/devicetree/bindings/arm/gic.txt |   55 ++++++++++
 arch/arm/common/Kconfig                       |    1 +
 arch/arm/common/gic.c                         |  142
+++++++++++++++++++------
 arch/arm/include/asm/hardware/gic.h           |    5 +-
 drivers/of/irq.c                              |  107 +++++++++++++++++++
 include/linux/irqdomain.h                     |   16 +++-
 include/linux/of_irq.h                        |    3 +
 kernel/irq/irqdomain.c                        |   12 +-
 8 files changed, 299 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Feb 2012 16:27:51 -0600
Subject: [PULL] generic irq chip and pl061 irqdomain support
Message-ID: <4F3ADFE7.4090409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

Please pull. This is based on your current branch which you have said
you plan to rebase, so feel free to rebase these as you need to. This
has been tested on highbank and i.MX5.


The following changes since commit 98ecf5260207e45ad587a5dc16c39f5ede467a45:

  irq_domain/microblaze: Convert microblaze to use irq_domains
(2012-02-05 23:02:26 -0700)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant

Rob Herring (3):
      ARM: kconfig: always select IRQ_DOMAIN
      irq: add irq_domain support to generic-chip
      gpio: pl061: enable interrupts with DT style binding

 .../devicetree/bindings/gpio/pl061-gpio.txt        |   15 ++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/common/Kconfig                            |    2 -
 drivers/gpio/gpio-pl061.c                          |   48 ++++---
 include/linux/irq.h                                |   15 ++
 kernel/irq/generic-chip.c                          |  152
+++++++++++++++++---
 6 files changed, 186 insertions(+), 48 deletions(-)

Rob

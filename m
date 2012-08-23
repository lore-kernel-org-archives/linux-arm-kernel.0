From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 10:47:51 +0800
Subject: [PATCH 0/3] pinctrl: sirf: add DT binding pinmux mapping support
Message-ID: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes us possible to define pinmux mapping support in board
specific .dts files directly.

As we want to add more SoCs(Marco, Polo) in mach-prima2, we want the dir
have no trivial PIN_MAP_MUX_GROUP_DEFAULT and pinctrl_register_mappings
codes.

we will have a clean mach-prima2/common.c file then.

Barry Song (3):
  ARM: PRIMA2: add missing interrupts property for pinctrl node
  ARM: PRIMA2: rename prima2-cb.dts to prima2.dtsi as it only has SoC
    features
  pinctrl: sirf: add DT-binding pinmux mapping support

 arch/arm/boot/dts/prima2-cb.dts    |  424 ------------------------
 arch/arm/boot/dts/prima2-evb.dts   |   37 ++
 arch/arm/boot/dts/prima2.dtsi      |  640 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/Makefile.boot |    2 +
 drivers/pinctrl/pinctrl-sirf.c     |   58 ++++-
 5 files changed, 736 insertions(+), 425 deletions(-)
 delete mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/boot/dts/prima2-evb.dts
 create mode 100644 arch/arm/boot/dts/prima2.dtsi



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

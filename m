From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:23:26 +0100
Subject: [For 3.8 PATCH 0/5] pinctrl-at91: add missing mux + gpio name + fix
Message-ID: <20121120212326.GO4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	The following patch series finish to add to the at91
	 - the missing mux support
	 - gpio names
	 - fix usart/uart naming
	 - macb pinctrl dt mux
	 - split the rts and cts as rs485 only need rts

The following changes since commit f6f94f6660dbe34039e5c86a46c7845589e7ee0c:

  pinctrl: at91: Staticize non-exported symbols (2012-11-05 14:30:45 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git 

for you to fetch changes up to c58c0c5acceb8acd3d447483a744e8a4a7c27f26:

  ARM: at91: dt: at91sam9260: split rts and cts pinctrl not (2012-11-19 07:50:56 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (5):
      pinctrl: at91: provide gpio names
      pinctrl: at91 add deglitch, debounce, pull down and schmitt trigger mux option support
      ARM: at91sam9: add macb pinctrl support
      ARM: at91: fix usart/uart namimg in pinctrl
      ARM: at91: dt: at91sam9260: split rts and cts pinctrl not

 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt |    9 +++++++--
 arch/arm/boot/dts/at91sam9260.dtsi                               |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 arch/arm/boot/dts/at91sam9263.dtsi                               |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 arch/arm/boot/dts/at91sam9263ek.dts                              |    5 ++++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi                      |   11 ++++++-----
 arch/arm/boot/dts/at91sam9g45.dtsi                               |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 arch/arm/boot/dts/at91sam9m10g45ek.dts                           |    5 ++++-
 arch/arm/boot/dts/at91sam9n12.dtsi                               |   62 +++++++++++++++++++++++++++++++++++++-------------------------
 arch/arm/boot/dts/at91sam9x25.dtsi                               |   21 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi                                |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/pinctrl/pinctrl-at91.c                                   |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 11 files changed, 501 insertions(+), 140 deletions(-)

Best Regards,
J.

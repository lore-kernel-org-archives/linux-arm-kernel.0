From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Jun 2016 11:35:53 -0700
Subject: [PATCH 0/3] ARM: dts: BCM5310x switch support
Message-ID: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds the Device Tree changes needed to enable the
Switch Register Access Block found on Broadcom BCM5301x SoCs.

First patch adds the SRAB block and the GMAC as child nodes of the BCMA
bus so we get proper device_node/struct device parenting. The second patch
defines the SRAB interrupts, and the last one defines the switch ports layouts
according to the new DSA binding accepted in net-next:

https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=8c5ad1d6179df31eea1b736c88296db6e3ffd25d

The B53 driver binding is defined here:

https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/diff/Documentation/devicetree/bindings/net/dsa/b53.txt?id=967dd82ffc52e9d8ea0defde094f9a39a3f4eeed

Florian Fainelli (3):
  ARM: dts: Enable SRAB switch and GMACs on 5301x DTS
  ARM: dts: BCM5301X: Add SRAB interrupts
  ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC

 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 40 +++++++++++++++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi               | 42 +++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

-- 
2.7.4

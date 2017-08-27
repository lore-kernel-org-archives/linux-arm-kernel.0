From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Aug 2017 14:54:22 +0200
Subject: [PATCH 0/3] arm64: dts: Initial ProBox2 Ava support
Message-ID: <20170827125425.3400-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds a Device Tree for the PROBOX2 AVA Android TV Box.

Unlike the Zidoo X9S, serial (loady) was the only working way to boot a new
kernel from the vendor's U-Boot on this TV Box.
PROBOX2 support has been informed about bootloader issues with Ethernet, USB
and FAT on SD; the same symptoms have since been observed on the Lake I, so
be warned that those bugs might inconvenience other RTD1295 devices, too.

More details at:
https://en.opensuse.org/HCL:ProBox2_Ava

@PROBOX2: Please review the following three patches and either signal your
acknowledgement of my naming with an "Acked-by: name <email>" line or point
out any changes you would like to see applied (e.g., company name). Thanks!

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: support at probox2.com
Cc: devicetree at vger.kernel.org

Cc: Wangchanchan <wangcc@azw-online.com>
Cc: beelinkservice at bee-link.com

Andreas F?rber (3):
  dt-bindings: Add vendor prefix for ProBox2
  dt-bindings: arm: realtek: Add ProBox2 AVA
  arm64: dts: realtek: Add ProBox2 Ava

 Documentation/devicetree/bindings/arm/realtek.txt  |  1 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/realtek/Makefile               |  1 +
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts | 31 ++++++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  6 -----
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  6 +++++
 6 files changed, 40 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts

-- 
2.12.3

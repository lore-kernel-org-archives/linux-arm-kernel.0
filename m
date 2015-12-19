From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Dec 2015 16:05:16 +0100
Subject: [linux-sunxi][PATCH v2 0/5] ARM: dt: sunxi: Add Itead Ibox support
Message-ID: <1450537521-6476-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

this patch series is an extension of the initial patch delivery for the
Itead Ibox as found here
https://groups.google.com/d/msg/linux-sunxi/GR_co3ObW8s/0BTPQljmAAAJ.

There seems to be a few Itead variants out there based on their A10/A20
core module and this patch series attempts to organise the device tree
files with some consideration that these variants may be added later.

I've also converted the A10 Itead Iteaduino dts to use these common files.
As I don't have this board to verify the changes I simply compared the
output of the fdtdump before and after applying these patches. The only
difference was the addition of codec support and a reduction to the dcdc2
max voltage.

BR,
CK

---
Changes since v1:
- Added audio codec.
- Seperated into individual patches
- added Itead A10 core dtsi
- modified sun4i-a10-itead-iteaduino-plus.dts to use itead common core dtsi

Marcus Cooper (5):
  ARM: dts: sunxi: Add sunxi-itead-core-common.dtsi
  ARM: dts: sun7i: Add Itead A20 Core support
  ARM: dts: sun7i: Add Itead Ibox support
  ARM: dts: sun4i: Add Itead A10 Core support
  ARM: dts: sun4i: Itead Iteaduino to use common code

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun4i-a10-itead-core.dtsi        |  86 ++++++++++++++++
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    | 102 +-----------------
 arch/arm/boot/dts/sun7i-a20-itead-core.dtsi        |  87 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         | 111 ++++++++++++++++++++
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     | 114 +++++++++++++++++++++
 6 files changed, 401 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-itead-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
 create mode 100644 arch/arm/boot/dts/sunxi-itead-core-common.dtsi

-- 
1.9.1

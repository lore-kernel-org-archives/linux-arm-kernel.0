From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:36 +0800
Subject: [PATCH v4 00/16] DTS for hi6220 and HiKey
Message-ID: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset include dts changes for hi6220 SoC and HiKey board. These
patches apply well one by one on top of next-20160401. All tested on HiKey
and pass.

To avoid merge conflicts with patches already ack'ed by maintainers,
I picked all hi6220/hikey dts related patches into this single patchset.
And they passed the tests on HiKey.

Patch 1~3 are from hi6220 cpuidle support. It has been reviewed and
ack'ed in maillist.
[PATCH v2 RESEND 0/4] arm64: Hi6220: enable CPU idle states:
http://archive.arm.linux.org.uk/lurker/message/20160121.105346.7d3b0470.en.html

Patch 4 is for hi6220 gpio.

Patch 5 is for pinctl.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Patch 6 is for spi configuration.

Patch 7 adds hi6220 i2c nodes, and
patch 8 enables them for hikey board usage.

Patch 9 adds add hi6220 usb node. It has been sent to maillist.
[PATCH] arm64: dts: add hi6220 usb node
http://thread.gmane.org/gmane.linux.drivers.devicetree/146062
http://thread.gmane.org/gmane.linux.drivers.devicetree/144335/focus=134022
Acked-by: Rob Herring <robh@kernel.org>

Patch 10 and 11 are from hi6220 mailbox support. It has been reviewed and
ack'ed in maillist.
[PATCH v7 RESEND 0/4] mailbox: hisilicon: add Hi6220 mailbox driver
http://thread.gmane.org/gmane.linux.kernel/2152759/focus=2152768
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Wei Xu <xuwei5@hisilicon.com>
Patch 13 adds gpio LEDs device nodes.

Patch 14 adds hi655x pmic dts node and regulator support.
[PATCH v8 5/5] arm64: dts: hisilicon: Add hi655x pmic dts node
http://thread.gmane.org/gmane.linux.kernel/2151688
Acked-by: Lee Jones <lee.jones@linaro.org>

Patch 15 adds dwmmc nodes description for hi6220. It refers to two LDO's
which are defined above.
Patch 16 adds wifi device node (TI's wl1835) for HiKey board.

v4:
- remove hikey-gpio.dtsi
- disable spi0 by default and let boards override it
- remove LDOs unit address
- fix style problems after review

v3:
- update patch 2 sp804 clocks and clock-names
- add Acked-by into commits where applies.

v2:
- picked hi655x pmic dts node.
- removed dw_mmc resets property, as it is still under review.
- add 'non-removable' into dw_mmc2 for wifi

Chen Feng (1):
  arm64: dts: hikey: Add hi655x pmic dts node

Guodong Xu (4):
  arm64: dts: hikey: enable i2c0 and i2c1 for working with mezzanine
    boards
  arm64: dts: hi6220: add pinctrl for uarts and enable them
  arm64: dts: add LED nodes for hi6220-hikey
  arm64: dts: add wifi nodes support for hi6220-hikey

Leo Yan (5):
  arm64: dts: Reserve memory regions for hi6220
  arm64: dts: add sp804 timer node for Hi6220
  arm64: dts: enable idle states for Hi6220
  arm64: dts: add mailbox node for Hi6220
  arm64: dts: add Hi6220's stub clock node

Xinwei Kong (2):
  arm64: dts: add all hi6220 i2c nodes
  arm64: dts: add dwmmc nodes for hi6220

Zhangfei Gao (1):
  arm64: dts: Add hi6220 usb node

Zhong Kaihua (3):
  arm64: dts: Add Hi6220 gpio configuration nodes
  arm64: dts: add Hi6220 pinctrl configuration nodes
  arm64: dts: add Hi6220 spi configuration nodes

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   | 200 ++++++-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 563 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 705 +++++++++++++++++++++++
 include/dt-bindings/pinctrl/hisi.h               |  59 ++
 4 files changed, 1522 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
 create mode 100644 include/dt-bindings/pinctrl/hisi.h

-- 
1.9.1

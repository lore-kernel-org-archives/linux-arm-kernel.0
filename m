From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:25:20 +0800
Subject: [RESEND PATCH v3 0/5] usb: change clock information for chipidea
Message-ID: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set changes usb clock information for legacy i.mx platforms.
At these platforms, they needs three clocks to let controller work.

Hi Shawn,

Fabio has tested for both imx27 and imx25 platforms.
I have queued 1/5 and 5/5, would you please help to queue others,
thanks.

Changes for v3:
- Delete property "needs-three-clocks", and using of_device_id->data
  to differentiate platforms
- change <stable@vger.kernel.org> #v3.19+ to <stable@vger.kernel.org> #v4.1+

Changes for v2:
- Add imx25 & imx27 dts change
- Add Fabio's tested-by and Cc: <stable@vger.kernel.org> #v3.19+
- Some typo and commit description

Peter Chen (5):
  doc: dt-binding: ci-hdrc-usb2: split vendor specific properties
  ARM: dts: imx27.dtsi: change the clock information for usb
  ARM: dts: imx25.dtsi: change the clock information for usb
  ARM: dts: imx35.dtsi: change the clock information for usb
  usb: chipidea: imx: refine clock operations to adapt for all platforms

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |  10 +-
 arch/arm/boot/dts/imx25.dtsi                       |   8 +-
 arch/arm/boot/dts/imx27.dtsi                       |  16 ++-
 arch/arm/boot/dts/imx35.dtsi                       |   8 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 | 156 ++++++++++++++++++---
 5 files changed, 164 insertions(+), 34 deletions(-)

-- 
1.9.1

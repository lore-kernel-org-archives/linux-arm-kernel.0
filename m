From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 14 Oct 2015 09:56:26 +0800
Subject: [PATCH v4 0/2] usb: change clock information for chipidea
Message-ID: <1444787788-29769-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set changes usb clock information for legacy i.mx platforms.
At these platforms, they needs three clocks to let controller work.

@Fabio, would you please help to test again, I am sorry to let you
test again.

Changes for v4:
- Following Rob Herring suggestion, if the platforms can get
clock using their dev_id, then, they are legacy platforms which
need three clocks to let controller work. If the dev_id is NULL,
then it only needs one clock.
- Only includes bug fix patches in this set, for new changes, will
through the next-tree.

Changes for v3:
- Delete property "needs-three-clocks", and using of_device_id->data
  to differentiate platforms
- change <stable@vger.kernel.org> #v3.19+ to <stable@vger.kernel.org> #v4.1+

Changes for v2:
- Add imx25 & imx27 dts change
- Add Fabio's tested-by and Cc: <stable@vger.kernel.org> #v3.19+
- Some typo and commit description

Peter Chen (2):
  ARM: dts: imx27.dtsi: change the clock information for usb
  usb: chipidea: imx: refine clock operations to adapt for all platforms

 arch/arm/boot/dts/imx27.dtsi       |  16 +++--
 drivers/usb/chipidea/ci_hdrc_imx.c | 132 ++++++++++++++++++++++++++++++++-----
 2 files changed, 126 insertions(+), 22 deletions(-)

-- 
1.9.1

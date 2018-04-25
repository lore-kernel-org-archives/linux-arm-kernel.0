From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 25 Apr 2018 16:50:38 +0200
Subject: [PATCH 0/2] can: flexcan: fix regression from v4.16-rc1
Message-ID: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

when porting the kernel from a i.MX25 based machine to 4.17-rc1 (but
still using the old dtb) can failed to probe. After some research we
noticed that a commit that was merged in the v4.16 merge window
introduced a change that broke using an older device tree.

This series first commit fixes the issue.
The second patch introduces a fallback compatible which matches the
usual dt-style on i.MX. (Before v4.16-rc1 there was a wrong fallback
compatible that was removed.)

Best regards
Uwe

Uwe Kleine-K?nig (2):
  can: flexcan: fix endianess detection
  arm: dts: imx[35]*: declare flexcan devices to be compatible to
    imx25's flexcan

 arch/arm/boot/dts/imx35.dtsi |  4 ++--
 arch/arm/boot/dts/imx53.dtsi |  4 ++--
 drivers/net/can/flexcan.c    | 26 ++++++++++++++------------
 3 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.17.0

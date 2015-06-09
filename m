From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:12 +0200
Subject: [PATCH 20/34] pinctrl: mvebu: armada-xp: fix binding documentation of
 ge1 pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was an off-by-one in the documentation of the ge1(txd[0-3])
pins, which is fixed by this commit. Since the driver was correct, and
the subnames are anyway not used in the DT binding itself, there is no
need to push this documentation fix for stable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index 0bd7d2f..f2d2d40 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -31,9 +31,9 @@ mpp9          9        gpio, ge0(rxd3), lcd(d9)
 mpp10         10       gpio, ge0(rxctl), lcd(d10)
 mpp11         11       gpio, ge0(rxclk), lcd(d11)
 mpp12         12       gpio, ge0(txd4), ge1(txclkout), lcd(d12)
-mpp13         13       gpio, ge0(txd5), ge1(txd1), lcd(d13)
-mpp14         14       gpio, ge0(txd6), ge1(txd2), lcd(d15)
-mpp15         15       gpio, ge0(txd7), ge1(txd3), lcd(d16)
+mpp13         13       gpio, ge0(txd5), ge1(txd0), lcd(d13)
+mpp14         14       gpio, ge0(txd6), ge1(txd1), lcd(d15)
+mpp15         15       gpio, ge0(txd7), ge1(txd2), lcd(d16)
 mpp16         16       gpio, ge0(txd7), ge1(txd3), lcd(d16)
 mpp17         17       gpio, ge0(col), ge1(txctl), lcd(d17)
 mpp18         18       gpio, ge0(rxerr), ge1(rxd0), lcd(d18), ptp(trig)
-- 
2.1.0

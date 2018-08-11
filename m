From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 11 Aug 2018 11:16:13 +0900
Subject: [PATCH v2] pinctrl: uniphier: drop meaningless pin from SD1 pin-mux
 of Pro4
Message-ID: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin 327 was supposed to be used as a voltage control line for the
SD card regulator, but the SD card port1 does not support UHS-I.  It
only supports 3.3V signaling, hence this pin is pointless.

Just a note about the background.  At first, hardware engineers tried
to implement the UHS for this port.  Then, they needed to shrink the
silicon die size, and gave up the UHS, but forgot to remove the pin
assignment.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - rebase onto linux-pinctrl/devel branch

 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 89148f8..6fca8d5 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1047,9 +1047,8 @@ static const unsigned nand_cs1_pins[] = {131, 132};
 static const int nand_cs1_muxvals[] = {1, 1};
 static const unsigned sd_pins[] = {150, 151, 152, 153, 154, 155, 156, 157, 158};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
-static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
-				    327};
-static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned int sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326};
+static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned spi0_pins[] = {199, 200, 201, 202};
 static const int spi0_muxvals[] = {11, 11, 11, 11};
 static const unsigned spi1_pins[] = {195, 196, 197, 198, 235, 238, 239};
-- 
2.7.4

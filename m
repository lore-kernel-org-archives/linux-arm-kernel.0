From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:07 +0200
Subject: [PATCH 15/34] pinctrl: mvebu: armada-39x: align NAND pin naming
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SoCs use "nand" to designate NAND pins, only Armada 39x is using
"nd", which is not consistent. This commit fixes that by renaming the
corresponding functions.

It also changes the subnames from rbn0/rbn1 to rb0/rb1, to respect the
convention used everywhere that we don't encode the 'n' part of signal
names.

While this commit changes the main name of function, therefore
potentially breaking the DT compatibility, this is not a problem since
Armada 39x is a brand new SoC which isn't used in production yet.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt        | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 34af69e..b6bd9cc 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -55,9 +55,9 @@ mpp37	37	gpio, sd0(d3), dev(ad8), ge(rxclk)
 mpp38	38	gpio, ref(clk), sd0(d0), dev(ad4), ge(rxd1)
 mpp39	39	gpio, i2c1(sck), ua0(cts), sd0(d1), dev(a2), ge(rxd2)
 mpp40	40	gpio, i2c1(sda), ua0(rts), sd0(d2), dev(ad6), ge(rxd3)
-mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burst/last), nd(rbn0), ge(rxctl)
+mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burst/last), nand(rb0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
-mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nd(rbn1)
+mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nand(rb1)
 mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index a5e3627..de91b35 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -241,7 +241,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(3, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs3",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "burst/last", V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(6, "nd",      "rbn0",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(6, "nand",    "rb0",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxctl",    V_88F6920_PLUS)),
 	MPP_MODE(42,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -255,7 +255,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(3, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs2",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "clkout",   V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(6, "nd",      "rbn1",     V_88F6920_PLUS)),
+		 MPP_VAR_FUNCTION(6, "nand",    "rb1",      V_88F6920_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
-- 
2.1.0

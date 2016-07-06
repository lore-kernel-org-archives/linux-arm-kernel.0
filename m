From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  7 Jul 2016 00:12:11 +0900
Subject: [PATCH] pinctrl: uniphier: add Ethernet pin-mux settings
Message-ID: <1467817932-7034-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the following Ethernet interfaces:

  PH1-LD4: MII, RMII
  PH1-Pro4: MII, RMII, RGMII
  PH1-sLD8: MII, RMII (Built-in PHY is also supported)
  ProXstream2: MII, RMII, RGMII
  PH1-LD6b: RMII, RGMII
  PH1-LD11: RMII (Built-in PHY is also supported)
  PH1-LD20: RMII, RGMII

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c |  6 ++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 13 ++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 14 +++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 14 +++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 26 ++++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 22 ++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 14 +++++++++++++
 7 files changed, 109 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 89a260e..77a0236 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -474,6 +474,9 @@ static const unsigned emmc_pins[] = {18, 19, 20, 21, 22, 23, 24, 25};
 static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
 static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
+static const unsigned ether_rmii_pins[] = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
+					   16, 17};
+static const int ether_rmii_muxvals[] = {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
 static const unsigned i2c0_pins[] = {63, 64};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {65, 66};
@@ -589,6 +592,7 @@ static const int xirq_alternatives_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c3),
@@ -815,6 +819,7 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
@@ -894,6 +899,7 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 7311453..aa8bd97 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -555,6 +555,13 @@ static const unsigned emmc_pins[] = {18, 19, 20, 21, 22, 23, 24, 25};
 static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
 static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
+static const unsigned ether_rgmii_pins[] = {30, 31, 32, 33, 34, 35, 36, 37, 38,
+					    39, 40, 41, 42, 43, 44, 45};
+static const int ether_rgmii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					  0, 0, 0, 0};
+static const unsigned ether_rmii_pins[] = {30, 31, 32, 33, 34, 35, 36, 37, 39,
+					   41, 42, 45};
+static const int ether_rmii_muxvals[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {63, 64};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {65, 66};
@@ -670,6 +677,8 @@ static const int xirq_alternatives_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_rgmii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c3),
@@ -903,6 +912,8 @@ static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
@@ -983,6 +994,8 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_ld20_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 98044bc..3edfb6f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -552,6 +552,14 @@ static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
 static const int emmc_muxvals[] = {0, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {28, 29, 30, 31};
 static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const unsigned ether_mii_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40,
+					  41, 42, 43, 136, 137, 138, 139, 140,
+					  141, 142};
+static const int ether_mii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					4, 4, 4, 4, 4, 4, 4};
+static const unsigned ether_rmii_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40,
+					   41, 42, 43};
+static const int ether_rmii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned i2c0_pins[] = {102, 103};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {104, 105};
@@ -655,6 +663,8 @@ static const int xirq_range1_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_mii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c2),
@@ -819,6 +829,8 @@ static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_mii_groups[] = {"ether_mii"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
@@ -880,6 +892,8 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_mii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 6c0d66c..708e510 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -745,6 +745,14 @@ static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
 static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
 static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const unsigned ether_rgmii_pins[] = {143, 144, 145, 146, 147, 148, 149,
+					    150, 151, 152, 153, 154, 155, 156,
+					    157, 158};
+static const int ether_rgmii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					  0, 0, 0, 0};
+static const unsigned ether_rmii_pins[] = {143, 144, 145, 146, 147, 148, 149,
+					   150, 152, 154, 155, 158};
+static const int ether_rmii_muxvals[] = {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {109, 110};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {111, 112};
@@ -873,6 +881,8 @@ static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(adinter),
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_rgmii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c2),
@@ -1151,6 +1161,8 @@ static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
 
 static const char * const adinter_groups[] = {"adinter"};
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
@@ -1241,6 +1253,8 @@ static const char * const xirq_groups[] = {
 static const struct uniphier_pinmux_function uniphier_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(adinter), /* Achip-Dchip interconnect */
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 002bd6e..c306e84 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1013,6 +1013,22 @@ static const unsigned emmc_pins[] = {40, 41, 42, 43, 51, 52, 53};
 static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {44, 45, 46, 47};
 static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const unsigned ether_mii_pins[] = {160, 161, 162, 163, 164, 165, 166,
+					  167, 168, 169, 170, 171, 172, 173,
+					  174, 175, 176, 177, 178, 179};
+static const int ether_mii_muxvals[] = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					0, 0, 0, 0, 0, 0, 0};
+static const unsigned ether_rgmii_pins[] = {160, 161, 162, 163, 164, 165, 167,
+					    168, 169, 170, 171, 172, 176, 177,
+					    178, 179};
+static const int ether_rgmii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					  0, 0, 0, 0};
+static const unsigned ether_rmii_pins[] = {160, 161, 162, 165, 168, 169, 172,
+					   173, 176, 177, 178, 179};
+static const int ether_rmii_muxvals[] = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned ether_rmiib_pins[] = {161, 162, 165, 167, 168, 169, 172,
+					    173, 176, 177, 178, 179};
+static const int ether_rmiib_muxvals[] = {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned i2c0_pins[] = {142, 143};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {144, 145};
@@ -1155,6 +1171,10 @@ static const int xirq_alternatives_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_mii),
+	UNIPHIER_PINCTRL_GROUP(ether_rgmii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmiib),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c2),
@@ -1439,6 +1459,9 @@ static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_mii_groups[] = {"ether_mii"};
+static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
+static const char * const ether_rmii_groups[] = {"ether_rgmii", "ether_rgmiib"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
@@ -1536,6 +1559,9 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_mii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 8e1d73e..85ca5e2 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -731,6 +731,19 @@ static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
 static const int emmc_muxvals[] = {9, 9, 9, 9, 9, 9, 9};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
 static const int emmc_dat8_muxvals[] = {9, 9, 9, 9};
+static const unsigned ether_mii_pins[] = {143, 144, 145, 146, 147, 148, 149,
+					  150, 151, 152, 153, 154, 155, 156,
+					  158, 159, 199, 200, 201, 202};
+static const int ether_mii_muxvals[] = {8, 8, 8, 8, 10, 10, 10, 10, 10, 10, 10,
+					10, 10, 10, 10, 10, 12, 12, 12, 12};
+static const unsigned ether_rgmii_pins[] = {143, 144, 145, 146, 147, 148, 149,
+					    150, 151, 152, 153, 154, 155, 156,
+					    157, 158};
+static const int ether_rgmii_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
+					  8, 8, 8, 8};
+static const unsigned ether_rmii_pins[] = {143, 144, 145, 146, 147, 148, 149,
+					   150, 152, 154, 155, 158};
+static const int ether_rmii_muxvals[] = {8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9};
 static const unsigned i2c0_pins[] = {109, 110};
 static const int i2c0_muxvals[] = {8, 8};
 static const unsigned i2c1_pins[] = {111, 112};
@@ -854,6 +867,9 @@ static const int xirq_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_mii),
+	UNIPHIER_PINCTRL_GROUP(ether_rgmii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c2),
@@ -1129,6 +1145,9 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_mii_groups[] = {"ether_mii"};
+static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
@@ -1217,6 +1236,9 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_mii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 8ea740d..da689d8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -480,6 +480,14 @@ static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
 static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {28, 29, 30, 31};
 static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const unsigned ether_mii_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14,
+					  61, 63, 64, 65, 66, 67, 68};
+static const int ether_mii_muxvals[] = {13, 13, 13, 13, 13, 13, 13, 13, 13, 13,
+					13, 13, 27, 27, 27, 27, 27, 27, 27};
+static const unsigned ether_rmii_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 13,
+					   14};
+static const int ether_rmii_muxvals[] = {13, 13, 13, 13, 13, 13, 13, 13, 13,
+					 13, 13, 13};
 static const unsigned i2c0_pins[] = {102, 103};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {104, 105};
@@ -589,6 +597,8 @@ static const int xirq_range1_muxvals[] = {
 static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
+	UNIPHIER_PINCTRL_GROUP(ether_mii),
+	UNIPHIER_PINCTRL_GROUP(ether_rmii),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c2),
@@ -745,6 +755,8 @@ static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
 };
 
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
+static const char * const ether_mii_groups[] = {"ether_mii"};
+static const char * const ether_rmii_groups[] = {"ether_rmii"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
@@ -807,6 +819,8 @@ static const char * const xirq_groups[] = {
 
 static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(emmc),
+	UNIPHIER_PINMUX_FUNCTION(ether_mii),
+	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
-- 
1.9.1

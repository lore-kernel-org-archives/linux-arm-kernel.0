From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 30 Jul 2018 06:00:45 +0800
Subject: [RFC PATCH] pinctrl: actions: s700_pads[] can be static
In-Reply-To: <20180729200038.11795-5-sravanhome@gmail.com>
References: <20180729200038.11795-5-sravanhome@gmail.com>
Message-ID: <20180729220045.GA5007@lkp-ib03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: e96a1c4b279a ("pinctrl: actions: Add Actions Semi S700 pinctrl driver")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pinctrl-s700.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-s700.c b/drivers/pinctrl/actions/pinctrl-s700.c
index 7e9d23a..df69827 100644
--- a/drivers/pinctrl/actions/pinctrl-s700.c
+++ b/drivers/pinctrl/actions/pinctrl-s700.c
@@ -225,7 +225,7 @@
 #define NUM_PADS		(_LASTPAD - _FIRSTPAD + 1)
 
 /* Pad names for the pinmux subsystem */
-const struct pinctrl_pin_desc s700_pads[] = {
+static const struct pinctrl_pin_desc s700_pads[] = {
 	PINCTRL_PIN(ETH_TXD0, "eth_txd0"),
 	PINCTRL_PIN(ETH_TXD1, "eth_txd1"),
 	PINCTRL_PIN(ETH_TXD2, "eth_txd2"),
@@ -1549,7 +1549,7 @@ static const char * const sirq2_groups[] = {
 	"sirq2_dummy",
 };
 
-const struct owl_pinmux_func s700_functions[] = {
+static const struct owl_pinmux_func s700_functions[] = {
 	[S700_MUX_NOR] = FUNCTION(nor),
 	[S700_MUX_ETH_RGMII] = FUNCTION(eth_rmii),
 	[S700_MUX_ETH_SGMII] = FUNCTION(eth_smii),
@@ -1697,7 +1697,7 @@ static PAD_PULLCTL_CONF(I2C2_SCLK, 2, 7, 1);
 /********PAD INFOS*****************************/
 
 /* Pad info table for the pinmux subsystem */
-struct owl_padinfo s700_padinfo[NUM_PADS] = {
+static struct owl_padinfo s700_padinfo[NUM_PADS] = {
 	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
 	[ETH_TXD1] = PAD_INFO_ST(ETH_TXD1),
 	[ETH_TXEN] = PAD_INFO_ST(ETH_TXEN),

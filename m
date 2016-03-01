From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Mar 2016 23:04:33 +0100
Subject: [PATCH 1/4] pinctrl: amlogic: Separate some pin functions for Meson8
 / Meson8b
In-Reply-To: <1456869876-19320-1-git-send-email-carlo@caione.org>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
Message-ID: <1456869876-19320-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Separate functions for pins controlled by different pin controllers.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 35 +++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 9677807..0c9572e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -694,7 +694,10 @@ static const char * const i2c_c_groups[] = {
 };
 
 static const char * const hdmi_groups[] = {
-	"hdmi_hpd", "hdmi_sda", "hdmi_scl", "hdmi_cec_0",
+	"hdmi_hpd", "hdmi_sda", "hdmi_scl", "hdmi_cec_0"
+};
+
+static const char * const hdmi_cec_groups[] = {
 	"hdmi_cec_1"
 };
 
@@ -770,12 +773,20 @@ static const char * const i2c_mst_ao_groups[] = {
 	"i2c_mst_sck_ao", "i2c_mst_sda_ao"
 };
 
-static const char * const clk_groups[] = {
-	"clk_24m_out", "clk_32k_in_out"
+static const char * const clk_24m_groups[] = {
+	"clk_24m_out",
+};
+
+static const char * const clk_32k_groups[] = {
+	"clk_32k_in_out",
 };
 
-static const char * const spdif_groups[] = {
-	"spdif_out_1", "spdif_out_0"
+static const char * const spdif_0_groups[] = {
+	"spdif_out_0"
+};
+
+static const char * const spdif_1_groups[] = {
+	"spdif_out_1"
 };
 
 static const char * const i2s_groups[] = {
@@ -789,7 +800,11 @@ static const char * const pwm_b_groups[] = {
 };
 
 static const char * const pwm_c_groups[] = {
-	"pwm_c0", "pwm_c1", "pwm_c2"
+	"pwm_c0", "pwm_c1"
+};
+
+static const char * const pwm_c_ao_groups[] = {
+	"pwm_c2"
 };
 
 static const char * const pwm_d_groups[] = {
@@ -827,6 +842,7 @@ static struct meson_pmx_func meson8b_functions[] = {
 	FUNCTION(uart_c),
 	FUNCTION(i2c_c),
 	FUNCTION(hdmi),
+	FUNCTION(hdmi_cec),
 	FUNCTION(spi),
 	FUNCTION(ethernet),
 	FUNCTION(i2c_a),
@@ -842,16 +858,19 @@ static struct meson_pmx_func meson8b_functions[] = {
 	FUNCTION(i2c_slave_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_mst_ao),
-	FUNCTION(clk),
-	FUNCTION(spdif),
+	FUNCTION(clk_32k),
+	FUNCTION(spdif_0),
+	FUNCTION(spdif_1),
 	FUNCTION(i2s),
 	FUNCTION(pwm_b),
 	FUNCTION(pwm_c),
+	FUNCTION(pwm_c_ao),
 	FUNCTION(pwm_d),
 	FUNCTION(pwm_e),
 	FUNCTION(pwm_vs),
 	FUNCTION(tsin_a),
 	FUNCTION(tsin_b),
+	FUNCTION(clk_24m),
 };
 
 static struct meson_bank meson8b_banks[] = {
-- 
1.9.1

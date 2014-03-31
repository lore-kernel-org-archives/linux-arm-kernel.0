From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 31 Mar 2014 17:18:12 +0200
Subject: [PATCH V2 11/19] mmc: mmci: Mark the DT bindings for highspeed mode
 as deprecated
In-Reply-To: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1396279100-2920-12-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common mmc DT parser supports bindings for highspeed mode, thus
there are no need for mmci to provide it's own versions for these. Mark
them as deprecated in the documentation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 2c8756f..03796cf 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -15,8 +15,6 @@ Required properties:
 Optional properties:
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
                            the ID provided by the HW
-- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
-- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
 - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
@@ -26,6 +24,10 @@ Optional properties:
 - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
 - st,sig-pin-fbclk       : feedback clock signal pin used.
 
+Deprecated properties:
+- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
+- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
+
 Example:
 
 sdi0_per1 at 80126000 {
@@ -42,8 +44,8 @@ sdi0_per1 at 80126000 {
 
 	max-frequency = <100000000>;
 	bus-width = <4>;
-	mmc-cap-sd-highspeed;
-	mmc-cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	cd-gpios  = <&gpio2 31 0x4>; // 95
 	st,sig-dir-dat0;
 	st,sig-dir-dat2;
-- 
1.7.9.5

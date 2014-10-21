From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:22:43 +0200
Subject: [PATCH RESEND 11/12] ARM: dts: berlin: Enable WiFi on Google
 Chromecast
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413883364-681-12-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SDHCI for BG2CD, we can now enable the port and allow to access
AzureWave WiFi/BT module on Google Chromecast.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index bcd81ffc495d..8c26a2dfd4a3 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -26,4 +26,13 @@
 	};
 };
 
+/*
+ * AzureWave AW-NH387 (Marvell 88W8787)
+ * 802.11b/g/n + Bluetooth 2.1
+ */
+&sdhci0 {
+	non-removable;
+	status = "okay";
+};
+
 &uart0 { status = "okay"; };
-- 
2.1.1

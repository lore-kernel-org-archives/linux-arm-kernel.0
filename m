From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 15 Sep 2014 12:52:33 +0200
Subject: [PATCH 2/3 v3] ARM: dts: exynos: Explicitly set dr_mode on
 arndale-octa
In-Reply-To: <1410778354-31210-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1410778354-31210-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1410778354-31210-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly set the dr_mode for the second dwc3 controller on the
Arndale Octa board to host mode. This is required to ensure the
controller is initialized in the right mode if the kernel is build with
USB gadget support

Reported-By: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 Changes in v3: new patch

 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 434fd9d..fc2e983 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -375,3 +375,7 @@
 		};
 	};
 };
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
-- 
2.1.0

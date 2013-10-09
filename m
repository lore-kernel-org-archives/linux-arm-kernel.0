From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:10 +0800
Subject: [PATCH 6/7] ARM: tegra: enable Tegra RTC for Venice2
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Tegra RTC device on Venice2. It also can be used as a wakeup
device when platform suspended.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 5859ec2..279c7b5 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -14,6 +14,10 @@
 		status = "okay";
 	};
 
+	rtc at 7000e000 {
+		status = "okay";
+	};
+
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 	};
-- 
1.8.4

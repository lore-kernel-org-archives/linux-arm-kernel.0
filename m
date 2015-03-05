From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 5 Mar 2015 07:13:30 -0600
Subject: [PATCH 3/4] ARM: dts: am43x-epos-evm: Add rtc node with ti,
 no-init property
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1425561211-31003-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rtc node with ti,no-init property so that rtc hwmod does not get
initialized as the RTC IP is disabled in hardware by the board layout
on am43x-epos-evm so the SoC cannot access the IP at all. Without this,
hwmod writes to the RTC SYSCONFIG register and causes a kernel panic
during boot.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 257c099..ba7dbc0 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -687,3 +687,7 @@
 		};
 	};
 };
+
+&rtc {
+	ti,no-init;
+};
-- 
2.3.0

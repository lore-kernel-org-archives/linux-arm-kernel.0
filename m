From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 30 Oct 2012 19:41:25 +0900
Subject: [PATCH 3/3] ARM: mvebu: Add support RTC for OpenBlockS AX3
In-Reply-To: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
References: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1351593685-19663-3-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

OpenBlockS AX3 has Seiko Instruments S-35390A as RTC controller.
This validates RTC controller.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/boot/dts/openblocks-ax3-4.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/openblocks-ax3-4.dts b/arch/arm/boot/dts/openblocks-ax3-4.dts
index c42b9a5..61c2f2c 100644
--- a/arch/arm/boot/dts/openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/openblocks-ax3-4.dts
@@ -74,6 +74,11 @@
 		i2c at d0011100 {
 			status = "okay";
 			clock-frequency = <400000>;
+
+			s35390a: s35390a at 30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			}; 
 		}; 
 	};
 };
-- 
1.7.10.4

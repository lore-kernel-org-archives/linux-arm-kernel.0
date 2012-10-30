From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 30 Oct 2012 19:41:24 +0900
Subject: [PATCH 2/3] ARM: mvebu: Add support I2C for OpenBlockS AX3
In-Reply-To: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
References: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1351593685-19663-2-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OpenBlockS AX3 uses the I2C controller on the mvebu.
This validates I2C controller and clock-frequency.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/openblocks-ax3-4.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/openblocks-ax3-4.dts b/arch/arm/boot/dts/openblocks-ax3-4.dts
index 7ef8052..c42b9a5 100644
--- a/arch/arm/boot/dts/openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/openblocks-ax3-4.dts
@@ -65,5 +65,15 @@
 				   linux,default-trigger = "heartbeat";
 			};
 		};
+
+		i2c at d0011000 {
+			status = "okay";
+			clock-frequency = <400000>;
+		}; 
+
+		i2c at d0011100 {
+			status = "okay";
+			clock-frequency = <400000>;
+		}; 
 	};
 };
-- 
1.7.10.4

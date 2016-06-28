From: stefan@agner.ch (Stefan Agner)
Date: Mon, 27 Jun 2016 23:27:53 -0700
Subject: [PATCH v4 1/5] ARM: dts: meson: minix-neo-x8: define PMIC as power
 controller
In-Reply-To: <20160628062757.24490-1-stefan@agner.ch>
References: <20160628062757.24490-1-stefan@agner.ch>
Message-ID: <20160628062757.24490-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMIC driver used to register itself as poweroff controller by
default, hence assuming that this device is using the PMIC as
system power controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 4f536bb..8bceb8d 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -80,6 +80,7 @@
 	pmic at 32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		system-power-controller;
 
 		regulators {
 		};
-- 
2.8.3

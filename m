From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 23 Jun 2018 00:06:31 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from lid
In-Reply-To: <20180622160631.8578-1-icenowy@aosc.io>
References: <20180622160631.8578-1-icenowy@aosc.io>
Message-ID: <20180622160631.8578-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
present. In this case if the lid is closed, systemd-logind will enter
s2idle mode by default; however there's no possible wakeup source
defined, so the system will enter a forever idle.

Add the lid itself as a wakeup source, thus the system can wakeup when
the lid is opened.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
This patch is not related with the first patch, and have no dependency.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 58253d6f9be1..e6e5bf11b759 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -49,6 +49,7 @@
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			linux,can-disable;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 02fecc42440c..33f78e745815 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -38,6 +38,7 @@
 			gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
+			wakeup-source;
 		};
 	};
 
-- 
2.17.1

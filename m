From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 10:48:07 +0100
Subject: [PATCH 07/15] ARM: ux500: Enable the SMSC9115 on Snowball via
 Device Tree
In-Reply-To: <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
Message-ID: <4F9676D7.1080506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2012 09:50:20 +0100
Subject: [PATCH 07/16] ARM: ux500: Enable the SMSC9115 on Snowball via Device Tree

Here we split the description of the external-bus at 50000000 over
two description files. In the more generic db8500 description file
we only specify the external-bus. Normally this would be used to
communicate with a NOR-flash device. On the Snowball however, the
SMSC9115 Ethernet chip occupies it. In the Snowball board specific
description file is where we actually specify that it is in fact the
Ethernet device which lives here.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 0ba0955..22b82cc 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -79,10 +79,16 @@
 			ranges;
 
 			ethernet at 50000000 {
-				compatible = "smsc,9111";
+				compatible = "smsc,lan9115";
 				reg = <0x50000000 0x10000>;
-				interrupts = <12 0x4>;
+				interrupts = <12 0x1>;
 				interrupt-parent = <&gpio4>;
+
+				reg-shift = <1>;
+				reg-io-width = <2>;
+				smsc,force-internal-phy;
+				smsc,irq-active-high;
+				smsc,irq-push-pull;
 			};
 		};
 
-- 
1.7.9.1

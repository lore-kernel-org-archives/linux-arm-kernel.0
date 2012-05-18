From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:02 +0100
Subject: [PATCH 03/16] ARM: ux500: Enable LED heartbeat functionality on
 Snowbal via DT
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the user LED on Snowball to double flash
every second or so, whilst it's still alive. This can give key
indications as to what the board is doing in the case of no
console output.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 6b00350..15ee419 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -68,6 +68,7 @@
 			label = "user_led";
 			gpios = <&gpio4 14 0x4>;
 			default-state = "on";
+			linux,default-trigger = "heartbeat";
 		};
 	};
 
-- 
1.7.9.5

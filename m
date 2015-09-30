From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 30 Sep 2015 16:15:37 +0800
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Add aliases for rtc devices
Message-ID: <1443600937-11071-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hummingbird A31 has 2 rtc devices available: one in the SoC, and
a pcf8563 external rtc on i2c2.

For some unknown reason, the onboard backup battery to power the
internal rtc when power is removed, and its time would reset. Hence
we want to use the external one by default.

Add aliases for the rtc devices with the external one as rtc0.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Can someone else with the Hummingbird A31 also test the internal RTC
and see if it doesn't survive power removal?

Thanks
ChenYu

---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 06d9391ca30e..358781113582 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -55,6 +55,8 @@
 
 	aliases {
 		serial0 = &uart0;
+		rtc0 = &pcf8563;
+		rtc1 = &rtc;
 	};
 
 	chosen {
-- 
2.5.3

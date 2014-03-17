From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:38 +0800
Subject: [PATCH 5/8] ARM: at91: sama5d3: clock for ssc from rk pin
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1395049541-28128-6-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to hardware design the clock for SSC device is from rk pin.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 0600153..306eef0 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -32,6 +32,10 @@
 				};
 			};
 
+			ssc0: ssc at f0008000 {
+				atmel,clk-from-rk-pin;
+			};
+
 			/*
 			 * i2c0 conflicts with ISI:
 			 * disable it to allow the use of ISI
-- 
1.8.5.2

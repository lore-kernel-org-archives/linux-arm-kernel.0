From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  2 Sep 2015 14:25:48 -0700
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
Message-ID: <1441229148-12095-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ddc-i2c-bus property was missing from the veyron dtsi file since
downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
nobody noticed when the veyron dtsi was sent upstream.  Add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note: I noticed that this was wrong but I don't currently have
graphics up and running on upstream on veyron.  Posting this anyway
since it's pretty clear that it's needed.  If someone else wants to
try it out that'd be nice, otherwise I'll put it on my list to figure
out how to get myself setup for graphics upstream.  ;)

 arch/arm/boot/dts/rk3288-veyron.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 2fa7a0d..275c78c 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -158,6 +158,7 @@
 };
 
 &hdmi {
+	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
 
-- 
2.5.0.457.gab17608

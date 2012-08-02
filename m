From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Aug 2012 08:34:25 +0800
Subject: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED
 Controller
In-Reply-To: <501904CB.9040104@free-electrons.com>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120801052424.GD1672@S2100-06.ap.freescale.net>
 <501904CB.9040104@free-electrons.com>
Message-ID: <20120802003422.GA2253@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 12:28:27PM +0200, Maxime Ripard wrote:
> Thanks for the tip.
> However, I'm not sure this device will be mxs specific, since this
> controller is used on some other devices as well (I know for example
> that some uses it with the Arduino, even though it's not related to
> Linux), so relying on mxs-specific capabilities here might not be that
> great.
> 
Ok, agreed.  In that case, putting "1" in last cell of oled-reset-gpio
does not make any point then.

+Examples:
+ssd1307: oled at 3c {
+        compatible = "solomon,ssd1307fb-i2c";
+        reg = <0x3c>;
+        pwms = <&pwm 4 3000>;
+        oled-reset-gpio = <&gpio2 7 1>;
+        oled-reset-active-low;
+};

-- 
Regards,
Shawn

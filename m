From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 11 Feb 2013 19:25:05 +1300
Subject: Devicetree node to turn off LCD when backlight is 'disabled'
Message-ID: <1360563905.4130.6.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was just wondering if the following would be an acceptable way to turn
off an lcd backlight when the pwm-backlight driver is set to level 0.
The LCD backlight is 'powered' by the gpio.

leds {
	compatible = "gpio-leds";
	backlight {
		label = "lcd-power";
		gpios = <&gpio 0 0 0>;  /* bank pin active_low */
		linux,default-trigger = "backlight";
		default-state = "on";
	};
};

The method has been tested by an end-user and confirmed as working - I
just wanted to check whether it is the 'accepted' way of doing it.

Regards
Tony Prisk

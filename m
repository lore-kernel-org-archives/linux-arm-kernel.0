From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 Jan 2015 20:10:44 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <54B94F61.2060706@ti.com>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com> <20150116155553.GC17658@lunn.ch>
 <54B94F61.2060706@ti.com>
Message-ID: <20150116191044.GA31577@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I understand that period of TLC chip cannot be changed and hence cannot
> fully implement PWM interface.

O.K, so that is agreed.

> But, suppose I want to control brightness
> of an LCD screen, with your current design, my LCD driver can never can do
> something like:
> 	pwm_get(chip);
> 	pwm_update_brightness();
> 	pwm_remove();
> I will always have to rely on sysfs entries to control brightness.

Or you can use the kernel API for controlling leds. There is a hint in

Documentation/devicetree/bindings/leds/common.txt

- linux,default-trigger :  This parameter, if present, is a
    string defining the trigger assigned to the LED.  Current triggers are:
     "backlight" - LED will act as a back-light, controlled by the framebuffer
                   system

So somebody has at least thought about this, and there is

drivers/leds/trigger/ledtrig-backlight.c

What i also find interesting is:

drivers/video/backlight/adp8860_bl.c
drivers/video/backlight/adp8870_bl.c
drivers/video/backlight/lm3639_bl.c

all implement an led_class driver. So it does seem some people think
backlight LEDs can be models using the led class.

	  Andrew

From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 24 Sep 2009 17:23:26 +0200
Subject: S3C64xx backlight PWM misinited GPIO pin
Message-ID: <4ABB8EEE.7070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Are the GPIO pins used as PWM (e.g. GPF15) supposed to be set to special
function 2 in the bootloader/mach file or is this just a bug in the PWM 
driver
in current mainline?

Without doing the below, backlight PWM doesn't work for me:


static int smartq_bl_init(struct device *dev)
{
     s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_SFN(2));

     return 0;
}

static struct platform_pwm_backlight_data smartq_backlight_data = {
...
     .init        = smartq_bl_init,
...
};


which doesn't look like it's the way to go..

Do I need to set some kind of config option (mach-hmt doesn't seem to 
need the
above change) or .. ?

Regards,

Maurus Cuelenaere

From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 28 Sep 2009 19:31:16 +0200
Subject: S3C64xx backlight PWM misinited GPIO pin
In-Reply-To: <87iqf3sede.fsf@macbook.be.48ers.dk>
References: <4ABB8EEE.7070103@gmail.com> <87iqf3sede.fsf@macbook.be.48ers.dk>
Message-ID: <4AC0F2E4.7040602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 28-09-09 09:43, Peter Korsgaard schreef:
 >  Maurus> Are the GPIO pins used as PWM (e.g. GPF15) supposed to be set
 >  Maurus> to special function 2 in the bootloader/mach file or is this
 >  Maurus> just a bug in the PWM driver in current mainline?
 >
 > The pin configuration imho doesn't belong in the pwm driver shared
 > between 24xx/64xx.

Agreed, but what about a 64xx (or 6410-specific if necessary) configuration?

IMHO this shouldn't go in the platform config, as the PWM GPIO pins are 
fixed
for all S3C6410-based devices.

 >  Maurus> Do I need to set some kind of config option (mach-hmt doesn't
 >  Maurus> seem to need the above change) or .. ?
 >
 > It doesn't do it because I setup the pin in the bootloader (E.G. to
 > display bootsplash image).

I suspected something like that, perhaps I should be doing this too.


Regards,

Maurus Cuelenaere

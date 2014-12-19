From: alexanders83@web.de (Alexander Stein)
Date: Fri, 19 Dec 2014 09:20:47 +0100
Subject: [PATCH] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <27289342.ORBlKX4LWa@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Am Freitag 19 Dezember 2014, 00:13:10 schrieb Alexandre Belloni:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> at91 will no longer export the mach/cpu.h and mach/hardware.h header files
> in the future, which would break building the atmel ac97c driver.
> 
> Since the cpu_is_* check is only used to find out whether we are running
> on avr32 or arm/at91, we can hardcode that check in the ARM case.
> 
> Unfortunately the driver is missing other work to be useful again on ARM,
> if anyone wants to actually use it, they need to add a DT binding, and
> the driver should really be converted to use the ASoC framework.

I recently send 3 patches to make DT working with this driver, you were on CC :). Please refer to http://comments.gmane.org/gmane.linux.alsa.devel/131686
I wonder though why all 3 are listed there although they were sent to different lists.

Best regards,
Alexander

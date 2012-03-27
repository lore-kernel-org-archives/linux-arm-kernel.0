From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue, 27 Mar 2012 16:19:01 +0800
Subject: =?UTF-8?Q?Question=EF=BC=9ALeds_handling_in_drivers?=
Message-ID: <CAK5ve-+p=RS00V=bmaCU6jYtX1R3X71dS4H7Zqd_f=UWQfVp+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I'm still working on the LEDS consolidation stuff and try to convert
the old style to LED CPU trigger driver [1].

But in drivers/char/nwflash.c:
---
$ grep leds_event drivers/char/nwflash.c
	leds_event(led_claim);
	leds_event(led_green_on);
	leds_event(led_release);
	leds_event(led_amber_on);
	leds_event(led_amber_off);
	leds_event(led_red_on);
				leds_event(led_amber_off);
				leds_event(led_red_on);
	leds_event(led_amber_off);
	leds_event(led_green_on);
---

It looks like very difficult to fit this in LEDS CPU trigger driver,
looks like an new LEDS trigger driver to indicate FLASH
reading/writing/verifying activities.
How do you think of this? Any suggestion?

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/088639.html

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com

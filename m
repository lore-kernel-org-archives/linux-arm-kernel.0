From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 14 Aug 2013 21:41:55 -0400
Subject: at91: watchdog: Can't get watchdog to trigger
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40153ADC7E586@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I am using Atmel's stable branch of the Linux kernel (https://github.com/linux4sam/linux-at91.git, branch linux-3.6.9-at91, back at commit 5fe012d4aee98ef82df66e6763882c735902ed0f) on a AT91SAM9G25 based board.  I am having issues getting the watchdog to trigger with this version of the kernel.

First, I've verified that the watchdog is enabled in the bootstrap and U-Boot.  I see the line:

at91sam9_wdt: enabled (heartbeat=15 sec, nowayout=0)

during boot showing that the watchdog is enabled.  I've tried triggering the watchdog by writing a single character to it from the command line (echo "0" > /dev/watchdog) and by using the two watchdog sample applications under Documentation/watchdog.  In every case I see the line:

watchdog watchdog0: watchdog did not stop!

But the board does not reset.  Just to make sure, I also set CONFIG_WATCHDOG_NOWAYOUT in the kernel configuration and I still have the same results.

I have my kernel configuration and the device tree files for my build over at https://github.com/evensonbryan/at91sam9g25-dt.git.  Other than the device tree files and the configuration, I have not made any kernel modifications.  What do I have setup wrong?

Thanks,
Bryan

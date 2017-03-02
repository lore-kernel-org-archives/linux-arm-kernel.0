From: rabin.vincent@axis.com (Rabin Vincent)
Date: Thu, 2 Mar 2017 15:13:56 +0100
Subject: DIfferent BogoMIPS value after bbaa06702719
 ("clocksource/drivers/arm_global_timer: Register delay timer")
In-Reply-To: <d22ec429-1a71-e56f-e1d7-28b066be8c1b@milecki.pl>
References: <d22ec429-1a71-e56f-e1d7-28b066be8c1b@milecki.pl>
Message-ID: <20170302141356.GC6763@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 02:36:23PM +0100, Rafa? Mi?ecki wrote:
> I just updated kernel on my SmartRG SR400ac (bcm4708-smartrg-sr400ac.dts) from
> 4.4 to 4.9 and noticed that this part of the log:
> [    0.020820] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
> (...)
> [    0.190806] Brought up 2 CPUs
> [    0.200022] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
> 
> became:
> [    0.027082] Calibrating delay loop (skipped), value calculated using timer frequency.. 800.00 BogoMIPS (lpj=4000000)
> (...)
> [    0.078858] Brought up 2 CPUs
> [    0.088254] SMP: Total of 2 processors activated (1600.00 BogoMIPS).
> 
> This is caused by commit bbaa06702719 ("clocksource/drivers/arm_global_timer:
> Register delay timer").
> 
> Is this something expected? Or should I be worried about this? I'm aware it's
> just BogoMIPS, but I still prefer to ask :)

Yes, it's expected.

No, you shouldn't be worried.

It's even explained on Wikipedia:
https://en.wikipedia.org/wiki/BogoMips#Timer-based_delays

You can run the udelay test (CONFIG_TEST_UDELAY) if you want to make
sure that your delay loops are fine.

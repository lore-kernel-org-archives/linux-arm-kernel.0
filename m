From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Fri, 15 May 2015 13:59:23 +0000
Subject: at91sam9: watchdog: period
In-Reply-To: <55559D55.6020703@aksignal.cz>
References: <55559D55.6020703@aksignal.cz>
Message-ID: <BN3PR0501MB109030A3B29685D9188F6B71BBC70@BN3PR0501MB1090.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiri,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Jir? Prchal
> Sent: Friday, May 15, 2015 3:17 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Boris Brezillon; Jean-Christophe Plagniol-Villard; Nicolas Ferre
> Subject: at91sam9: watchdog: period
> 
> Hi all,
> I'm trying to discover what's wrong with watchdog on my board. I didn't find
> anything about it on internet so I would ask you for help.
> I have a board with sam9g25 and slow clock xtal 32768Hz with 10p capacitors
> to GND. Frequency seems to be good since hwclock (RTC) runs pretty
> precisely powered from backup and main power too (no NTP). But watchdog
> time to reset is still 61s regardless default (16s) or 4s heartbeat setting. No
> change to WDT_MR in bootstrap, so in Linux should work.

I have the same hardware setup and the watchdog timeout is 15 seconds for me.  For my kernel, I am using the Atmel fork at github.com/linux4sam/linux-at91, master branch at commit 5d5b332821753d616e65da6237f0a3330e59b98f.  Even though this is based upon the 3.10 kernel, there isn't much that has changed with regard to the RTC or watchdog between 3.10 and 4.03; Atmel has been good on backporting their changes to their fork.  Maybe try an older kernel and see if the problem goes away?


Regards,
Bryan

> Here is dump:
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.0.2_cpm9g25 (prchal at prchal) (gcc version 4.7.3
> (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #10
> PREEMPT Thu May 14 15:20:24 CEST 2015
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
> cr=0005317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine model: AKsignal CDU9G25_v6
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] AT91: Detected soc type: at91sam9x5
> [    0.000000] AT91: Detected soc subtype: at91sam9g25
> ...
> [    4.669669] AT91: Starting after watchdog reset
> [    4.675675] at91sam9_wdt: enabled (heartbeat=4 sec, nowayout=1)
> ...
> 
> / # killall watchdog
> [ 1821.114114] watchdog watchdog0: nowayout prevents watchdog being
> stopped!
> / # [ 1821.123123] watchdog watchdog0: watchdog did not stop!
> [ 1882.294294] at91sam9_wdt: I will reset your machine !
> 
> Thanks for any help.
> Jiri
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

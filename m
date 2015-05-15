From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Fri, 15 May 2015 09:16:37 +0200
Subject: at91sam9: watchdog: period
Message-ID: <55559D55.6020703@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I'm trying to discover what's wrong with watchdog on my board. I didn't find anything about it on internet so I would 
ask you for help.
I have a board with sam9g25 and slow clock xtal 32768Hz with 10p capacitors to GND. Frequency seems to be good since 
hwclock (RTC) runs pretty precisely powered from backup and main power too (no NTP). But watchdog time to reset is still 
61s regardless default (16s) or 4s heartbeat setting. No change to WDT_MR in bootstrap, so in Linux should work.
Here is dump:
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.2_cpm9g25 (prchal at prchal) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #10 
PREEMPT Thu May 14 15:20:24 CEST 2015
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: AKsignal CDU9G25_v6
[    0.000000] Memory policy: Data cache writeback
[    0.000000] AT91: Detected soc type: at91sam9x5
[    0.000000] AT91: Detected soc subtype: at91sam9g25
...
[    4.669669] AT91: Starting after watchdog reset
[    4.675675] at91sam9_wdt: enabled (heartbeat=4 sec, nowayout=1)
...

/ # killall watchdog
[ 1821.114114] watchdog watchdog0: nowayout prevents watchdog being stopped!
/ # [ 1821.123123] watchdog watchdog0: watchdog did not stop!
[ 1882.294294] at91sam9_wdt: I will reset your machine !

Thanks for any help.
Jiri

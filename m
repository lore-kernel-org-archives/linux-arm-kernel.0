From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Feb 2015 14:13:40 +0100
Subject: [PATCH v2,
 RFC] RTC: PXA: Fix regression of interrupt before ioremap
In-Reply-To: <54D3D444.30008@tul.cz> (Petr Cvek's message of "Thu, 05 Feb 2015
 21:36:20 +0100")
References: <54CA1ECA.8050000@tul.cz> <87fvatnzl7.fsf@free.fr>
 <54CF90F1.4020703@tul.cz> <87a90wb1uq.fsf@free.fr>
 <54D0D034.1060204@tul.cz> <87siemalt6.fsf@free.fr>
 <54D3D444.30008@tul.cz>
Message-ID: <87egq19857.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> I was thinking more about setting alarm, ending the OS (and all processes),
> powering down DRAM, SRAM etc. and then waiting for alarm (like x86 BIOS alarm)
> to restart.
Ah yes, this is a case I have not considered before.
Yet I fail to see what the open/close removal patch fixes.

>> Yes, true, yet how do you set on a specific RTC block the alarm if you have many
>> of them on the system ?
>
> I thought it should be possible with ioctl with appropriate /dev/rtcX opened or /sys/class/rtc/rtcX/wakealarm . 
>
> It seems driver still does not work properly (with reverted patch). For first
> run the /sys/class/rtc/rtcX/wakealarm file is not created, but it is created for
> next reload of rtc-pxa module. And it seems that it is caused by .can_wakeup
> somewhere.
Do you know why, and would you have a patch for that ?

Cheers.

-- 
Robert

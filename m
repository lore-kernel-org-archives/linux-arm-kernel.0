From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Wed, 20 May 2015 14:39:57 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <20150519120433.763a416e@bbrezillon>
References: <55559D55.6020703@aksignal.cz>	<20150515172516.005e3a21@bbrezillon>	<5559865F.9010502@aksignal.cz>	<20150518092750.449d6c8c@bbrezillon>	<5559A029.9060007@aksignal.cz>	<555AA8F1.80100@atmel.com>	<20150519091442.675b1a98@bbrezillon>	<555AFBFD.3010506@aksignal.cz>	<20150519111402.747e8eb2@bbrezillon>	<555B07D0.4030000@aksignal.cz>
 <20150519120433.763a416e@bbrezillon>
Message-ID: <555C809D.8090407@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19.5.2015 12:04, Boris Brezillon wrote:
>> I'm confused. Why need kernel to know the time in witch userspace process will reset watchdog?
>
> This time is not exposed to userspace, it's the internal heartbeat used
> by the driver to refresh the watchdog.

Kernel driver does refresh? For what is utility "watchdog" in busybox?
When I stop this util then it will reboot.

>
>> And how to change watchdog expiration time?
>
> With the atmel,max-heartbeat-sec property.

No effect on it, still 61s.

>
> Anyway, that does not explain why your system takes 61 secs to trigger
> a reset (instead of 16 secs).
> Can you try to revert this commit [1] ?

Because of our company internet policy I can't clone git so I tried kernel 3.18.13.
No change, still 61s.

>
>
> [1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/drivers/watchdog/at91sam9_wdt.c?id=d677772e1358924bf487cd833bdc4d50f3f6f64d
>

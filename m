From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Oct 2018 13:30:40 +0100
Subject: [PATCH] arm/twd: avoid waking deeply sleeping CPUs for rate
 change notifier
In-Reply-To: <1540812888.2582.4.camel@pengutronix.de>
References: <20180417104627.29643-1-l.stach@pengutronix.de>
 <1528733761.2842.8.camel@pengutronix.de>
 <1540812888.2582.4.camel@pengutronix.de>
Message-ID: <ff107e3a-8dd2-8a1c-381b-ac54eea84fec@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2018 12:34, Lucas Stach wrote:
> Hi again,
> 
> Am Montag, den 11.06.2018, 18:16 +0200 schrieb Lucas Stach:
>> Hi all,
>>
>> Am Dienstag, den 17.04.2018, 12:46 +0200 schrieb Lucas Stach:
>>> The current clock notifier sends an IPI to all CPUs, even if they are in
>>> deep sleep state with the local timer disabled and switched to tick
>>> broadcast. This needlessly cuts the CPU sleep times, as nothing is gained
>>> from updating a disabled TWDs rate.
>>>
>>> Keep track of the enabled TWDs and only send an IPI to those CPUs with an
>>> active local timer. As disabled TWDs may now miss a CPU frequency update
>>> we need to make sure to refresh the rate on re-enabling of the timer.
>>>
>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>
>> I would appreciate some feedback to this patch.
>> FWIW, I've been running some systems with this patch applied for quite
>> some time now with no issues spotted so far.
> 
> Can I persuade anyone to take a look at this?
> It's been some months since I've posted this and haven't got any
> feedback so far. I'm running this patch on a bunch of devices ever
> since posting it and could not spot any adverse effects.

At the first glance, feature and code looks for me.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

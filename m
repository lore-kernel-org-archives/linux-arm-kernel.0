From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Thu, 07 Jul 2011 18:09:56 +0400
Subject: [PATCH V3 2/4] ARM: smp_twd: mpcore_wdt: Fix watchdog counter
	loading
In-Reply-To: <201107071444.19569.arnd@arndb.de>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
	<1310041396-2461-2-git-send-email-vkuzmichev@mvista.com>
	<201107071444.19569.arnd@arndb.de>
Message-ID: <4E15BE34.3010807@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 07/07/2011 04:44 PM, Arnd Bergmann wrote:
> On Thursday 07 July 2011, Vitaly Kuzmichev wrote:
>> Although the commit "98af057092f8f0dabe63c5df08adc2bbfbddb1d2
>>  ARM: 6126/1: ARM mpcore_wdt: fix build failure and other fixes"
>> resolved long standing mpcore_wdt driver build problems, it
>> introduced an error in the relationship between the MPcore watchdog
>> timer clock rate and mpcore_margin, "MPcore timer margin in seconds",
>> such that watchdog timeouts are now arbitrary rather than the number
>> of seconds specified by mpcore_margin.
>>
>> This change restores mpcore_wdt_keepalive() to its equivalent
>> implementation prior to commit 98af057 such that watchdog timeouts now
>> occur as specified by mpcore_margin.
>>
>> The variable 'mpcore_timer_rate' which caused that build failure was
>> replaced by 'twd_timer_rate'. Adding exported function to obtain
>> 'twd_timer_rate' value in mpcore_wdt driver.
>>
>> MPCORE_WATCHDOG needed to build 'mpcore_wdt' already depends on
>> HAVE_ARM_TWD needed to build 'smp_twd', so from the point of view of
>> 'mpcore_wdt' driver the exported function will always exist.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
>> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
> 
> Looks good now,

Unfortunately, I forgot to change to change EXPORT_SYMBOL ->
EXPORT_SYMBOL_GPL.
Ignore this patch and review PATCH V4 2/4 instead.
Sorry for troubles.

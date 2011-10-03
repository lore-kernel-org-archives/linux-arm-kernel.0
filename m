From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 15:03:30 +0530
Subject: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
In-Reply-To: <5173921.eT2vCfT35d@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-29-git-send-email-arnd@arndb.de>
	<4E894A95.5030107@ti.com> <5173921.eT2vCfT35d@wuerfel>
Message-ID: <4E89816A.5050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 02:45 PM, Arnd Bergmann wrote:
> On Monday 03 October 2011 11:09:33 Santosh Shilimkar wrote:
>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>>> index bb8f4a6..f7ef9f4 100644
>>> --- a/arch/arm/plat-omap/Kconfig
>>> +++ b/arch/arm/plat-omap/Kconfig
>>> @@ -217,6 +217,11 @@ config OMAP_PM_NOOP
>>>  
>>>  endchoice
>>>  
>>> +config OMAP_CPU_FREQ
>>> +     def_bool "y"
>>> +     depends on CPU_FREQ
>>> +     select CPU_FREQ_TABLE
>>> +
>>>  endmenu
>> With CPUFREQ series from Kevin [1], I don't think we need this any-more.
> 
> I guess if it's needed, it should at least be moved to the new cpufreq
> location.
> 
Probably you are right. CPU_FREQ_TABLE is selected today if
CPU_FREQ_STAT or CPU_FREQ_GOV_ONDEMAND is selected. Without these two
enabled, in won't be selected.

>> More so, I didn't find OMAP_CPU_FREQ is being used anywhere on mainline.
> 
> Yes, OMAP_CPU_FREQ is a symbol that is intentionally unused, with the
> only purpose of selecting CPU_FREQ_TABLE if any omap platform together
> with CPU_FREQ is enabled.
>
I see. This wasn't clear to me.

> Let's drop this patch for now, if it is still needed as I think, I can
> do a patch during the 3.2 cycle for the right location.
> 
Ok.

Regards
Santosh

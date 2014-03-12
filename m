From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 13 Mar 2014 06:11:50 +0800
Subject: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
In-Reply-To: <5320DA8A.3080904@ti.com>
References: <1394660600-3771-1-git-send-email-nm@ti.com>
 <5320D8AD.5000308@ti.com> <5320DA8A.3080904@ti.com>
Message-ID: <5320DBA6.5090107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014 06:07 AM, Nishanth Menon wrote:
> On 03/12/2014 04:59 PM, Santosh Shilimkar wrote:
>> On Thursday 13 March 2014 05:43 AM, Nishanth Menon wrote:
>>> Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
>>> CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
>>> failure complaining about the following:
>>> arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
>>> :(.text+0x8a70): undefined reference to `pm44xx_errata'
>>>
>> Not entirely accurate since CPU hotplug doesn't depend on CONFIG_PM
> 
> Just reporting the build error here.
>>
>>> Fixes: c962184 (ARM: OMAP4: PM: add errata support)
>>> Reported-by: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>
>>> Patch based on: v3.14-rc6
>>> Reported originally with a randconfig defconfig: http://slexy.org/view/s21U7eF4k1
>>>
>> But without the PM sleep code, hotplug won't work either.
> yep - agreed,
>> SO I think its ok assumption in this particular case
> 
> Can I take that as an Ack here? or would you suggest any improvements?
> 
yep. Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.ocm>

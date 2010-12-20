From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 08:21:19 -0600
Subject: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
In-Reply-To: <20101220113322.GS31404@nokia.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-3-git-send-email-nm@ti.com>
	<AANLkTi=4DJAnXcTZ37rcmr9Kz2CmXx6uhPqNThnoR2gu@mail.gmail.com>
	<20101220113322.GS31404@nokia.com>
Message-ID: <4D0F665F.8050804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter 'p2' De Schrijver had written, on 12/20/2010 05:33 AM, the following:
[..]
>>> +       /* these 2 words need to be at the end !!! */
>>> +kick_counter:
>>> +       .word   0
>>> +wait_dll_lock_counter:
>>> +       .word   0
>> Why do they need to be at the end? Also, at the end of what do they need to be?
>>
> 
> At the end of omap34xx_cpu_suspend. As we don't know where in SRAM the
> counters will be, the code accessing those counters addresses them
> relative from (_omap_sram_idle + omap34xx_cpu_suspend_sz). Not sure if
> this part of the code made it to linux-omap though.
I have not posted the change needed to expose these counters to 
userspace waiting for the churn in sleep34xx.S to settle down.

-- 
Regards,
Nishanth Menon

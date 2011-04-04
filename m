From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 4 Apr 2011 22:23:18 +0800
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <4D99D251.6000901@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
Message-ID: <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/4/4 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Hi Ming,
>
> On Saturday 02 April 2011 10:57 AM, Ming Lei wrote:
>>
>> Hi Avik,
>>
>> 2011/4/1 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>
>>> Hi,
>>>
>>> I've applied the patches in
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
>>> on top of a linaro kernel which resulted in booting problem on
>>> Pandaboard.
>>> It hangs inside the cti_unlock() while reading the LOCKSTATUS value,
>>> which
>>> happens when omap_init_pmu() is called. Please help me debug the issue.
>>
>> Please check if ?l3 clocks are enabled to drive CTI, such as done in
>> below:
>>
>> ? ? ? ?omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>> ? ? ? ?omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>> ? ? ? ?omap_writel(2, CM_EMU_CLKSTCTRL);
>> ? ? ? ?while ((omap_readl(CM_EMU_CLKSTCTRL)& ?0x300) != 0x300);
>>
> Can you please tell me where should I insert the above code to enable l3
> clocks to drive CTI?

It should be inserted before calling omap4_configure_pmu_irq.

thanks,
-- 
Ming Lei

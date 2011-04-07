From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 7 Apr 2011 17:54:27 +0800
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <4D9D7E8E.7020200@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
	<BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
	<4D9AF790.7010504@linux.vnet.ibm.com>
	<BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
	<4D9D7E8E.7020200@linux.vnet.ibm.com>
Message-ID: <BANLkTinzr300_4AM9kJO-NVXx7zPj8GYVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Avik,

Please check if the option CONFIG_PM is enabled or not.

If not, please try to enable it to see you issue can be fixed.


2011/4/7 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Hi Ming,
>
> On Wednesday 06 April 2011 11:37 AM, Ming Lei wrote:
>>
>> Hi Avik,
>>
>> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>
>>> Even after using ioremapped addresses in omap_writel() I'm getting the
>>> oops.
>>> Can you please point me to the location in mainline, where these l3
>>> clocks
>>> are enabled?
>>
>> I guess you can find here:
>>
>> ? ? ? ? ?l3_main_3_ick&& ?l3_instr_ick:
>> arch/arm/mach-omap2/clock44xx_data.c
>>
>> the clocks are set as ENABLE_ON_INIT.
>
> Those clocks are also set ENABLE_ON_INIT in the linaro kernel. But still
> it's hanging at "val = __raw_readl(base + LOCKSTATUS);" in cti_unlock(),
> even after explicitly enabling it using:
>
> omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
> omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
> omap_writel(2, CM_EMU_CLKSTCTRL);
> while ((omap_readl(CM_EMU_CLKSTCTRL) & 0x300) != 0x300);
>
> BTW, the oops were fixed by replacing omap_writel with __raw_writel.
>
> Regards,
> Avik
>
>>
>> thanks,
>
>


thanks,
-- 
Ming Lei

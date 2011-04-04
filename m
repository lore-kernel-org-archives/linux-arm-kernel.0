From: aviksil@linux.vnet.ibm.com (Avik Sil)
Date: Mon, 04 Apr 2011 19:44:41 +0530
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
Message-ID: <4D99D251.6000901@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming,

On Saturday 02 April 2011 10:57 AM, Ming Lei wrote:
> Hi Avik,
>
> 2011/4/1 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> Hi,
>>
>> I've applied the patches in
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
>> on top of a linaro kernel which resulted in booting problem on Pandaboard.
>> It hangs inside the cti_unlock() while reading the LOCKSTATUS value, which
>> happens when omap_init_pmu() is called. Please help me debug the issue.
>
> Please check if  l3 clocks are enabled to drive CTI, such as done in below:
>
>         omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>         omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>         omap_writel(2, CM_EMU_CLKSTCTRL);
>         while ((omap_readl(CM_EMU_CLKSTCTRL)&  0x300) != 0x300);
>
Can you please tell me where should I insert the above code to enable l3 
clocks to drive CTI?

Regards,
Avik

> No such issue on mainline since this clocks are enabled automatically.
>
> thanks,

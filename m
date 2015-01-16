From: thomas.lendacky@amd.com (Tom Lendacky)
Date: Fri, 16 Jan 2015 08:45:30 -0600
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54B8BB24.2020408@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <54B8BB24.2020408@linaro.org>
Message-ID: <54B9240A.7060003@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2015 01:17 AM, Hanjun Guo wrote:
> On 2015?01?16? 02:23, Catalin Marinas wrote:
>> Hi Grant,
>>
>> On Thu, Jan 15, 2015 at 04:26:20PM +0000, Grant Likely wrote:
>>> On Wed, Jan 14, 2015 at 3:04 PM, Hanjun Guo <hanjun.guo@linaro.org>
>>> wrote:
>>>> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>>>
>>> I'll get right to the point: Can we please have this series queued up
>>> for v3.20?
>>
>> Before you even ask for this, please look at the patches and realise
>> that there is a complete lack of Reviewed-by tags on the code (well,
>> apart from trivial Kconfig changes). In addition, the series touches on
>> other subsystems like clocksource, irqchip, acpi and I don't see any
>> acks from the corresponding maintainers. So even if I wanted to merge
>
> For the ACPI part, Rafael already said that "Having looked at the
> patches recently, I don't see any major problems in them from the ACPI
> core perspective, so to me they are good to go." [1]
> Is that kind of ack for this ?
>
> Thanks
> Hanjun
>
> [1]:
> http://lkml.iu.edu/hypermail/linux/kernel/1409.1/03363.html
>

I have tested ACPI-enablement patches for the amd-xgbe/amd-xgbe-phy
drivers that I'm about to submit upstream with the V7 patch series
on the AMD Seattle server platform. There does not appear to be support
for the _CCA attribute in this patch series. The amd-xgbe driver will
setup the device domain and cache attributes based on the presence of
this attribute, but it requires the arch support to assign the proper
DMA operations in order for it to all work correctly.

Overriding the _CCA attribute in the driver, I was able to successfully
test the driver and this patch series.

Thanks,
Tom


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

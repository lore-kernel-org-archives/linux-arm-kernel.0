From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Mar 2014 13:23:15 +0900
Subject: [PATCH v2 2/4] drivers: clk: use CONFIG_COMMON_CLK_SAMSUNG for
 Samsung clock support
In-Reply-To: <53298B26.8020400@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
 <1394598781-3848-3-git-send-email-pankaj.dubey@samsung.com>
 <53298B26.8020400@samsung.com>
Message-ID: <532A6D33.7080301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2014 09:18 PM, Tomasz Figa wrote:
> Hi Pankaj,
>
> On 12.03.2014 05:32, Pankaj Dubey wrote:
>> This patch includes Samsung clock Kconfig file, and replaces PLAT_SAMSUNG
>> with COMMON_CLK_SAMSUNG for Samsung common clock support.
>> Any Samsung SoC want to use Samsung common clock infrastructure can simply
>> select COMMON_CLK_SAMSUNG.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/clk/Kconfig  |    2 ++
>>   drivers/clk/Makefile |    2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 7641965..f2b6179 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -112,3 +112,5 @@ source "drivers/clk/qcom/Kconfig"
>>   endmenu
>>
>>   source "drivers/clk/mvebu/Kconfig"
>> +
>> +source "drivers/clk/samsung/Kconfig"
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index a367a98..f1da6ee 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -38,7 +38,7 @@ obj-$(CONFIG_PLAT_ORION)        += mvebu/
>>   obj-$(CONFIG_ARCH_MXS)            += mxs/
>>   obj-$(CONFIG_COMMON_CLK_QCOM)        += qcom/
>>   obj-$(CONFIG_ARCH_ROCKCHIP)        += rockchip/
>> -obj-$(CONFIG_PLAT_SAMSUNG)        += samsung/
>> +obj-$(CONFIG_COMMON_CLK_SAMSUNG)    += samsung/
>>   obj-$(CONFIG_ARCH_SHMOBILE_MULTI)    += shmobile/
>>   obj-$(CONFIG_ARCH_SIRF)            += sirf/
>>   obj-$(CONFIG_ARCH_SOCFPGA)        += socfpga/
>>
>
> This patch makes samsung/ subdirectory compile depending on 
> CONFIG_COMMON_CLK_SAMSUNG, but nothing selects it yet and thus breaking 
> bisection.
>
> Best regards,
> Tomasz
>

Thanks for review.
OK, I will take care of this in next revision.

-- 
Best Regards,
Pankaj Dubey

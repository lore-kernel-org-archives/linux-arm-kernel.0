From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 23 Jul 2015 16:48:54 +0100
Subject: [PATCH v8 8/9] nvmem: sunxi: Move the SID driver to the nvmem
 framework
In-Reply-To: <55B105B6.7000502@i2se.com>
References: <1437403352-4091-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1437403462-4432-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55B105B6.7000502@i2se.com>
Message-ID: <55B10CE6.2080001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/07/15 16:18, Stefan Wahren wrote:
> Hi Srinivas,
>
> Am 20.07.2015 um 16:44 schrieb Srinivas Kandagatla:
>> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Now that we have the nvmem framework, we can consolidate the common
>> driver code. Move the driver to the framework, and hopefully, it will
>> fix the sysfs file creation race.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> [srinivas.kandagatla: Moved to regmap based EEPROM framework]
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-sunxi-sid   |  22 ---
>>   .../bindings/misc/allwinner,sunxi-sid.txt          |  17 ---
>>   .../bindings/nvmem/allwinner,sunxi-sid.txt         |  21 +++
>>   drivers/misc/eeprom/Kconfig                        |  13 --
>>   drivers/misc/eeprom/Makefile                       |   1 -
>>   drivers/misc/eeprom/sunxi_sid.c                    | 156 --------------------
>>   drivers/nvmem/Kconfig                              |  11 ++
>>   drivers/nvmem/Makefile                             |   2 +
>>   drivers/nvmem/sunxi_sid.c                          | 159 +++++++++++++++++++++
>>   9 files changed, 193 insertions(+), 209 deletions(-)
>>   delete mode 100644 Documentation/ABI/testing/sysfs-driver-sunxi-sid
>>   delete mode 100644 Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
>>   delete mode 100644 drivers/misc/eeprom/sunxi_sid.c
>>   create mode 100644 drivers/nvmem/sunxi_sid.c
>>
>> [...]
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index ff44fe9..4328b93 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -8,3 +8,5 @@ nvmem_core-y			:= core.o
>>   # Devices
>>   obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
>>   nvmem_qfprom-y			:= qfprom.o
>> +obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
>> +nvmem_sunxi_sid-y		:= sunxi_sid.o
>
> is it really necessary to have 2 lines for a single driver?
>
> Why not the following line?
>
> obj-$(CONFIG_NVMEM_SUNXI_SID)	+= sunxi_sid.o
>
We can do that, but only reason i did it this way is to make the module 
naming consistent like nvmem_*.ko

--srini

> Regards
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

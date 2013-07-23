From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 23 Jul 2013 11:52:18 +0100
Subject: [PATCH v4] xen/arm: enable PV control for ARM
In-Reply-To: <5228e08a-1cdb-4240-b10f-9ad690c94ac4@email.android.com>
References: <1374529321-12955-1-git-send-email-julien.grall@linaro.org>
 <5228e08a-1cdb-4240-b10f-9ad690c94ac4@email.android.com>
Message-ID: <51EE6062.3080304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 01:32 AM, Konrad Rzeszutek Wilk wrote:
> Julien Grall <julien.grall@linaro.org> wrote:
>> Enable power management from the toolstack for ARM guest.
>>
>> Signed-off-by: Julien Grall <julien.grall@linaro.org>
>>
>> ---
>>    Changes in v4:
>>        - Divide the patch in 2 distinct parts
>>    Changes in v3:
>>        - Fix condition to compile cpu_hotplug.o
>>    Changes in v2:
>>        - Don't compile xen/cpu_hotplug.o with ARM64
>> ---
>> drivers/xen/Makefile |    3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>> index a609353..f185e8d 100644
>> --- a/drivers/xen/Makefile
>> +++ b/drivers/xen/Makefile
>> @@ -1,9 +1,8 @@
>> ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
>> -obj-y	+= manage.o
>> obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>> endif
>> obj-$(CONFIG_X86)			+= fallback.o
>> -obj-y	+= grant-table.o features.o events.o balloon.o time.o
>> +obj-y	+= grant-table.o features.o events.o balloon.o time.o manage.o
>> obj-y	+= xenbus/
>>
>> nostackp := $(call cc-option, -fno-stack-protector)
> 
> The patch looks Ok but the description is off.  Power management is the term used for cpu freq,  C states and P states. While this patch touches none of that. 
> 

What about : "Enable lifecycle (reboot, shutdown) management from the
toolstack for ARM guest"?

-- 
Julien

From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 Aug 2014 16:38:26 +0800
Subject: [PATCH v2 17/18] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <20140818142745.GV20043@localhost>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-18-git-send-email-hanjun.guo@linaro.org>
 <20140818142745.GV20043@localhost>
Message-ID: <53F30D02.1040306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-18 22:27, Catalin Marinas wrote:
> On Mon, Aug 04, 2014 at 04:28:24PM +0100, Hanjun Guo wrote:
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 3f5f745..f6b6791 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -5,8 +5,7 @@
>>  menuconfig ACPI
>>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>>  	depends on !IA64_HP_SIM
>> -	depends on IA64 || X86
>> -	depends on PCI
>> +	depends on ((IA64 || X86) && PCI) || ARM64
> 
> depends on (ARM64 && EXPERT)? (together with default on if CONFIG_ACPI
> is enabled).

I will update that in next version.

Thanks for all your comments!

Hanjun

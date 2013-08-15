From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 14:51:15 +0100
Subject: [PATCH Resend 1/3] PSCI: add missing dependency on CONFIG_OF
 for PSCI.
In-Reply-To: <520BE088.5060109@cogentembedded.com>
References: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
 <1376500987-12797-2-git-send-email-jonathan.austin@arm.com>
 <520BE088.5060109@cogentembedded.com>
Message-ID: <520CDCD3.8010505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 14/08/13 20:54, Sergei Shtylyov wrote:
> Hello.
>
> On 08/14/2013 09:23 PM, Jonathan Austin wrote:
>
>> The PSCI initialisation depends on data found in the DT. Without this the
>> including PSCI support makes little sense, and furthermore the of_* stub
>> functions aren't broad enough to ensure that this builds without CONFIG_OF.
>
>> As there is little enthusiasm for extending these stubs without useful use-cases
>> (of which this is *not* an example) this patch prevents building of PSCI
>> without CONFIG_OF.
>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>> ---
>>    arch/arm/Kconfig |    1 +
>>    1 file changed, 1 insertion(+)
>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index ba412e0..972ec25 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1577,6 +1577,7 @@ config HOTPLUG_CPU
>>    config ARM_PSCI
>>    	bool "Support for the ARM Power State Coordination Interface (PSCI)"
>>    	depends on CPU_V7
>> +	depends on CONFIG_OF
>
>      I think you meant just OF. :-)
>

Yikes, sure did.

Thanks.
Jonny

> WBR, Sergei
>
>

From: dave.long@linaro.org (David Long)
Date: Mon, 03 Feb 2014 21:15:15 -0500
Subject: [PATCH v5 16/16] ARM: Remove uprobes dependency on kprobes
In-Reply-To: <1391442358.3509.19.camel@linaro1.home>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
 <1390507559-4697-17-git-send-email-dave.long@linaro.org>
 <1391442358.3509.19.camel@linaro1.home>
Message-ID: <52F04D33.5080208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/14 10:45, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-01-23 at 15:05 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Now that arm uprobes support has been made separate from the arm kprobes code
>> the Kconfig can be changed to reflect that.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index fec5a6b..9ddc4ae 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -204,7 +204,6 @@ config NEED_DMA_MAP_STATE
>>          def_bool y
>>
>>   config ARCH_SUPPORTS_UPROBES
>> -	depends on KPROBES
>>   	def_bool y
>>
>>   config ARCH_HAS_DMA_SET_COHERENT_MASK
>
>
> Was this patch meant to have other contents? If not, it seems a bit
> pointless as all it does is remove a line added in the previous patch,
> so should just be folded into that one.
>

That patch was added late to a much earlier rev.  It should have been 
merged with the previous patch before now.  I have just done so.

-dl

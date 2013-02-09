From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 21:56:29 +0000
Subject: [PATCH 02/17] ARM: set BE8 if LE in head code
In-Reply-To: <5116C1DD.1070906@gmail.com>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-3-git-send-email-ben.dooks@codethink.co.uk>
 <5116C1DD.1070906@gmail.com>
Message-ID: <6f283e2a929e7d58a9cac86ac59d2f63@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 21:38, Rob Herring wrote:
> On 02/08/2013 05:17 PM, Ben Dooks wrote:
>> If we are booting in LE and compiled for BE8, then change the 
>> processor
>> state in the head code. Since the instruction stream is always LE, 
>> we
>> do not need to do anything special.
>>
>> Also ensure that the secondary processors are started in the same 
>> mode.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  arch/arm/boot/compressed/head.S |    3 +++
>>  arch/arm/kernel/head.S          |    3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/compressed/head.S 
>> b/arch/arm/boot/compressed/head.S
>> index fe4d9c3..39940a7 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -134,6 +134,9 @@ start:
>>  		.word	_edata			@ zImage end address
>>   THUMB(		.thumb			)
>>  1:
>> +#ifdef CONFIG_CPU_BE8_BOOT_LE
>
> Can't you use CONFIG_CPU_BIG_ENDIAN here rather than a new config 
> option?

For this, we can probably do this as it is a no-op, however other parts
of the patch series do need this to allow it to boot from a little 
endian
booting environment.

-- 
Ben

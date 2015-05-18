From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 18 May 2015 10:43:29 +0300
Subject: [PATCH v2 1/5] kasan, x86: move KASAN_SHADOW_OFFSET to the arch
 Kconfig
In-Reply-To: <1431775656.2341.10.camel@x220>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-2-git-send-email-a.ryabinin@samsung.com>
 <1431775656.2341.10.camel@x220>
Message-ID: <55599821.40409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2015 02:27 PM, Paul Bolle wrote:
> On Fri, 2015-05-15 at 16:59 +0300, Andrey Ryabinin wrote:
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
> 
>> +config KASAN_SHADOW_OFFSET
>> +	hex
>> +	default 0xdffffc0000000000
> 
> This sets CONFIG_KASAN_SHADOW_OFFSET for _all_ X86 configurations,
> doesn't it?
> 

Right.

>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>  
>> -config KASAN_SHADOW_OFFSET
>> -	hex
>> -	default 0xdffffc0000000000 if X86_64
> 
> While here it used to depend, at least, on HAVE_ARCH_KASAN. But grepping
> the tree shows the two places where CONFIG_KASAN_SHADOW_OFFSET is
> currently used are guarded by #ifdef CONFIG_KASAN. So perhaps the
> default line should actually read
> 	default 0xdffffc0000000000 if KASAN
> 
> after the move. Would that work?
> 

Yes, but I would rather add "depends on KASAN".

> 
> Paul Bolle
> 
> 

From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 1 Dec 2016 16:04:09 -0800
Subject: [PATCH v4 1/3] lib: add bitrev8x4()
In-Reply-To: <20161201234523.3bed63dc@crub>
References: <cover.1480551148.git.stillcompiling@gmail.com>
 <bc92eb1507448731163ae67fc888668d327f9168.1480551148.git.stillcompiling@gmail.com>
 <20161201234523.3bed63dc@crub>
Message-ID: <8fb2f1c2-c39c-b74f-d5c8-d6731cbd67c8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anatolij,

Thanks for the review.

On 12/01/2016 02:45 PM, Anatolij Gustschin wrote:
> On Thu,  1 Dec 2016 09:04:50 -0800
> Joshua Clayton stillcompiling at gmail.com wrote:
> ...
>> diff --git a/arch/arm/include/asm/bitrev.h b/arch/arm/include/asm/bitrev.h
>> index ec291c3..6d2e9ca 100644
>> --- a/arch/arm/include/asm/bitrev.h
>> +++ b/arch/arm/include/asm/bitrev.h
>> @@ -17,4 +17,9 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
>> 	return __arch_bitrev32((u32)x) >> 24;
>> }
>>
>> +static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
>> +{
>> +	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
> 	return x;
Oops thats a little embarrassing;
I'll add a return.
>> +}
> otherwise you get
>
> In function '__arch_bitrev8x4':
> warning: no return statement in function returning non-void [-Wreturn-type]
>
> --
> Anatolij

I wonder why I do not see this warning when compiling. The inlining, maybe?


Joshua

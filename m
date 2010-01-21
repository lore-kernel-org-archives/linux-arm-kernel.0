From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 21 Jan 2010 11:52:47 -0500
Subject: Question: locomo_{read/write}l macros
In-Reply-To: <4B581CD2.9010007@ru.mvista.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909020E8DFF@mi8nycmail19.Mi8.com>
	<4B581CD2.9010007@ru.mvista.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E8EFF@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 21, 2010 2:22 AM, Sergei Shtylyov wrote:
> Hello.
> 
> H Hartley Sweeten wrote:
> 
>> Hello all,
>>
>> Is there a reason why the locomo stuff is using custom
>> macros for {read/write}l access?
>>
>> In arch/arm/include/asm/hardware/locomo.h:
>>
>> #define locomo_writel(val,addr)	({ *(volatile u16 *)(addr) = (val); })
>> #define locomo_readl(addr)	(*(volatile u16 *)(addr))
>>
>> It appears that these are just non-typesafe versions of the
>> __raw_{read/write}w macros in arch/arm/include/asm/io.h:
>>   
>
>   You mean __raw_{read/write}l for sure?

No.

The locomo_* macros are both using u16 *.  The equivalent __raw_*
macros would be the unsigned short * type which is __raw_{read/write}w.

Plus, all the masking used with locomo_{read/write}l uses 16-bit
values.  My guess is the names used for the locomo_* macros are
wrong.

Regards,
Hartley

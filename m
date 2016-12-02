From: agust@denx.de (Anatolij Gustschin)
Date: Fri, 2 Dec 2016 08:51:57 +0100
Subject: [PATCH v4 1/3] lib: add bitrev8x4()
In-Reply-To: <8fb2f1c2-c39c-b74f-d5c8-d6731cbd67c8@gmail.com>
References: <cover.1480551148.git.stillcompiling@gmail.com>
 <bc92eb1507448731163ae67fc888668d327f9168.1480551148.git.stillcompiling@gmail.com>
 <20161201234523.3bed63dc@crub>
 <8fb2f1c2-c39c-b74f-d5c8-d6731cbd67c8@gmail.com>
Message-ID: <20161202085157.1a6ec811@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

On Thu, 1 Dec 2016 16:04:09 -0800
Joshua Clayton stillcompiling at gmail.com wrote:
...
>>> +static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
>>> +{
>>> +	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));  
>> 	return x;  
>Oops thats a little embarrassing;
>I'll add a return.
>>> +}  
>> otherwise you get
>>
>> In function '__arch_bitrev8x4':
>> warning: no return statement in function returning non-void [-Wreturn-type]
>>
>
>I wonder why I do not see this warning when compiling. The inlining, maybe?

do you have CONFIG_HAVE_ARCH_BITREVERSE=y in your .config?
Probably not optimized code is used, otherwise you will send wrong
data to FPGA (due to wrong return values from __arch_bitrev8x4).

Anatolij

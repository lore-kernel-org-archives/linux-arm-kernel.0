From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 07 Sep 2012 16:48:02 +1000
Subject: [PATCH] ARM: ep93xx: Fix build error due to 'SZ_32M' undeclared
In-Reply-To: <CAF+7xWko4wokuU-OiMYq3a2RJyaSb=qXM+LOpJCKHYpEB1Xi2Q@mail.gmail.com>
References: <1346675368.15950.0.camel@phoenix> <5049346B.5020205@gmail.com>
 <CAF+7xWko4wokuU-OiMYq3a2RJyaSb=qXM+LOpJCKHYpEB1Xi2Q@mail.gmail.com>
Message-ID: <504998A2.6000705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/12 15:48, Axel Lin wrote:
>> Hi Axel,
>>
>> The patch looks fine. I notice that the other ep93xx boards are also
>> using the SZ_ defines, but are indirectly including linux/sizes.h via
>> asm/memory.h, which in turn is indirectly included via asm/io.h. That
> Seems this is also true for other platforms ( e.g. mach-pxa, mach-ux500, etc)
> 
>> seems a bit flaky, so I wonder if we should just explicitly include
>> <linux/sizes.h> in all the board files which use the SZ_ macros as per
>> the patch below. Thoughts?
> I'm 50/50 on this.
> But if we do these changes, this patch is more than a build fix.

Fair enough,

I've applied your patch as-is to my ep93xx-fixes branch.

Thanks,
~Ryan

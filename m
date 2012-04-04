From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 4 Apr 2012 21:41:21 +0200
Subject: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
In-Reply-To: <4F7C9C89.9080605@codeaurora.org>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-3-git-send-email-j-pihet@ti.com>
 <4F7C9C89.9080605@codeaurora.org>
Message-ID: <4F7CA3E1.2050809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2012 9:10 PM, Trilok Soni wrote:
> Hi Jean,
>
> On 3/19/2012 9:42 PM, jean.pihet at newoldbits.com wrote:
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> Move the driver specific macros from the smartreflex header file
>> (arch/arm/mach-omap2/smartreflex.h) in a new header file
>> include/linux/power/smartreflex.h.
>>
>> This change makes the SmartReflex implementation ready for the move
>> to drivers/.
>
> I wonder why someone would need a new directory under drivers/power
> where the code is not about introducing new and generic AVS framework
> but it is all about OMAP specific code.

The main motivation is that it's a driver and thus does not have 
anything to do inside mach-omap2.

Where will you put that otherwise?

> What if tomorrow new generic
> AVS framework comes from different chip vendor? I am sure this kind
> of technology would be common in newer embedded chips.

Probably, but this is hard to know with only one implementation so far 
in the kernel.
I guess when someone else will start pushing some new AVS driver inside 
the AVS directory, we might realize that there is enough common part to 
create a frwmk.

IIRC, David Brownell was referring to the rule of three for such case. 
Meaning that it worth having a generic fmwk when at least three 
different drivers are doing the same kind of things.

Regards,
Benoit

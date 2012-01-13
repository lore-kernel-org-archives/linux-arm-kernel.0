From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 17:21:31 -0600
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
 <20120113164336.GA1068@n2100.arm.linux.org.uk> <4F106299.8050306@gmail.com>
 <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
Message-ID: <4F10BC7B.4040405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 01/13/2012 02:46 PM, Nicolas Pitre wrote:
> On Fri, 13 Jan 2012, Rob Herring wrote:
> 
>> On 01/13/2012 10:43 AM, Russell King - ARM Linux wrote:
>>> On Fri, Jan 13, 2012 at 10:34:02AM -0600, Rob Herring wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Since asm/irq.h may not include mach/irqs.h, include mach/irqs.h directly.
>>>
>>> Rather than doing this, we should be eliminating the need for these
>>> old drivers to include mach/irqs.h at all.
>>>
>>> Adding the resources to the platform device, and then using at least
>>> the IRQ resource(s) would be a definite step forward (and a relatively
>>> easy one to do.)
>>>
>>
>> Well, this has just happened in 3.3. So I can now drop this one I think.
> 
> Another problem that resources solve (and your original patch didn't 
> make it any better nor worse) has to do with include file search paths.  
> Once we start building more than one SOC in the kernel, we won't be able 
> to support the inclusion of <mach/whatever.h> from driver code anymore 
> since this could refer to more than one instances of 
> arch/arm/mach-*/include/mach/whatever.h.

I'm fully aware of this issue and was not trying to solve that here. On
the positive side, it does help highlight drivers which are not single
kernel ready by explicitly including mach headers which is easily
searched for.

I'm finding some new breakage as I rebase to the latest mainline
(gpio-pxa.c). So the next version may have a few more fixes like this one.

Rob

From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 26 Feb 2014 18:13:27 -0500
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
Message-ID: <530E7517.2010806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2014 05:49 PM, Rob Herring wrote:
> On Wed, Feb 26, 2014 at 1:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
>>> ARM VM System Specification
>>> ===========================
>>>
>>> Goal
>>> ----
>>> The goal of this spec is to allow suitably-built OS images to run on
>>> all ARM virtualization solutions, such as KVM or Xen.
>>>
>>> Recommendations in this spec are valid for aarch32 and aarch64 alike, and
>>> they aim to be hypervisor agnostic.
>>>
>>> Note that simply adhering to the SBSA [2] is not a valid approach,
>>> for example because the SBSA mandates EL2, which will not be available
>>> for VMs.  Further, the SBSA mandates peripherals like the pl011, which
>>> may be controversial for some ARM VM implementations to support.
>>> This spec also covers the aarch32 execution mode, not covered in the
>>> SBSA.
>>
>> I would prefer if we can stay as close as possible to SBSA for individual
>> hardware components, and only stray from it when there is a strong reason.
>> pl011-subset doesn't sound like a significant problem to implement,
>> especially as SBSA makes the DMA part of that optional. Can you
>> elaborate on what hypervisor would have a problem with that?
> 
> The SBSA only spec's a very minimal pl011 subset which is only
> suitable for early serial output. Not only is there no DMA, but there
> are no interrupts and maybe no input. I think it also assumes the uart
> is enabled and configured already by firmware. It is all somewhat
> pointless because the location is still not known or discoverable by
> early code. Just mandating a real pl011 would have been better, but I
> guess uart IP is value add for some. There is a downside to the pl011
> which is the tty name is different from x86 uarts which gets exposed
> to users and things like libvirt.

Can you just use /dev/console? That's what I use in my init scripts for
portability from PL011 to DCC.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

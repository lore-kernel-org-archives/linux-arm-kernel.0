From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 26 Mar 2010 12:13:39 -0600
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <4BACF238.3040405@firmworks.com>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
	<1269610665.807.51.camel@e102109-lin.cambridge.arm.com>
	<4BACF238.3040405@firmworks.com>
Message-ID: <fa686aa41003261113o7cd8612eh9b51904114902a3a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 11:43 AM, Mitch Bradley <wmb@firmworks.com> wrote:
> Catalin Marinas wrote:
>> On Thu, 2010-03-25 at 21:04 +0000, Russell King - ARM Linux wrote:
>>> On Wed, Mar 24, 2010 at 09:11:56AM -0600, Grant Likely wrote:
>>>> *IRQs disabled
>>>> *MMU off
>>>> *Instruction cache either on or off
>>>> *Data cache turned off
>>>
>>> Would recommend saying "Data cache(s) turned off" so that L2 cache is
>>> included.
>>
>> There are platforms where the L2 cache is turned on by the boot monitor
>> (secure monitor) and Linux has no control over it (I think OMAP).
>
> What is the reason for turning off the data caches? ?Leaving all caches
> turned on and coherent with one another has always worked well for me at the
> interface from firmware to a booted program.

Data cache off is specified in Documentation/arm/Booting in the Linux
source tree and I used that document as a starting point to get
discussion going.  I don't have a technical argument either way.

Russell, what is the reason for having the data cache off?

g.

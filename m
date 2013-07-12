From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 12 Jul 2013 13:33:27 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <20130712140643.2a3f1c68@skate>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
 <20130712140643.2a3f1c68@skate>
Message-ID: <51DFF797.8080100@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/13 13:06, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Fri, 12 Jul 2013 12:58:45 +0100, Ben Dooks wrote:
>
>>> Yeah, the Thumb2 code is not supported by Ben Dooks patches, it's part
>>> of the TODO-list. I think Ben said he would probably not have much time
>>> to work on this. I might be able to spare some time on this, so just
>>> let me know if I should start working on this. If I remember correctly,
>>> it's mainly the fixup_pv_table code that needed some Thumb2/BE love.
>>>
>>> Will, is getting Thumb2 working a requirement to get the BE support
>>> merged, or can we for now make the BE option depends on !THUMB2_KERNEL ?
>>
>> I would like to sort out getting this code merged as it seems to have
>> been tested by several people now outside Codethink.
>
> I briefly talked with Will this week at LCE, and apparently he was
> generally ok with the patches. He only mentioned that the series should
> be split between core ARM stuff (that goes through Russell's tree), and
> the platform-specific changes, that go through the different
> maintainers tree.

The 311/be/core series which was the first posted has a few machine
specific bits in it (vexpress, highbank and mvebu) but is mainly the
ARM core code and bits of peripheral specific support which still live
under arch/arm.

I left there there as they're fairly small patches and would tend to get
lost. I can remove these before asking RMK to pull the core support and
possibly the atag/boot-endian patches.

>> I could try doing the THUMB2 support, but I do not have a lot of
>> experience with building THUMB2 kernels.
>
> Ok. Let me know if you need some help. I'd really like to see this BE
> work make it into 3.12.

Thanks for the testing. I'll see if I can get some time in early next
week to re-test and send against 3.11-rc series.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

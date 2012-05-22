From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 22 May 2012 13:00:23 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB5AFF4.7060900@gmail.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <20120517233512.GH16338@titan.lakedaemon.net> <4FB5AFF4.7060900@gmail.com>
Message-ID: <4FBB7FD7.4060604@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/12 03:12, Rob Herring wrote:
> On 05/17/2012 06:35 PM, Jason Cooper wrote:
>> On Tue, May 15, 2012 at 08:31:06AM -0500, Rob Herring wrote:
>>> marvell is the documented vendor string, not mrvl.
>>
>> When Arnd and I were adding the initial kirkwood support for devicetree,
>> the common wisdom was to use the stock ticker symbol when available.
>> Hence, mrvl, iom, and dlink (only on taiwanese exchange, which uses
>> numbers)...
>
> Yes, that's true. But consistency is more important. If we have cases of
> both, then one needs to be deprecated.

I'd go for "should" instead of "needs". I would say it would be nice
to settle on marvell.

There are already instances of "mrvl" in the kernel, see

	drivers/i2c/busses/i2c-pxa.c
	drivers/tty/serial/pxa.c
	drivers/rtc/rtc-mv.c
	drivers/rtc/rtc-sa1100.c

Do people mind if the original compatibilities are left in to avoid
having to rename .dts file contents, or are we happy to go with just
"marvell"?

Also, it seems that some of the marvell bluetooth firmware is defined
to be mrvl prefixed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

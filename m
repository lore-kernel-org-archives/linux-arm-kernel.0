From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 30 Aug 2010 09:21:43 -0700
Subject: [PATCH] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <4C7BCFC9.7050004@criticallink.com> (Michael Williamson's message
	of "Mon, 30 Aug 2010 11:35:37 -0400")
References: <4C78FA26.4040801@criticallink.com>
	<87k4n89m3s.fsf@deeprootsystems.com>
	<4C7BCFC9.7050004@criticallink.com>
Message-ID: <87mxs48414.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

[...]

>>> +struct mtd_partition mityomapl138_nandflash_partition[] = {
>>> +	{
>>> +		.name		= "rootfs",
>>> +		.offset		= 0,
>>> +		.size		= SZ_128M,
>>> +		.mask_flags	= 0, /* MTD_WRITEABLE, */
>>> +	},
>>> +	{
>>> +		.name		= "homefs",
>>> +		.offset		= MTDPART_OFS_APPEND,
>>> +		.size		= MTDPART_SIZ_FULL,
>>> +		.mask_flags	= 0,
>>> +	},
>>> +};
>> It's your board, you can have your partitions however you choose, but
>> just curious... Is your bootloader somehwhere in NAND too?  Also 128M
>> seems pretty small for a root filesystem.
>>
> The bootloader (u-boot) and kernel is on an onboard SPI-NOR device.  I was
> going add the SPI stuff and the appropriate partitions on a next round
> of patches (if this one makes it) per your guidance.  It's not needed to get
> the kernel up and running, which was why we left it out.  There's nothing
> precluding using NAND for storing the bootloader, etc., but by default we
> weren't going to do that.  

OK, thanks for the clarification.  As I mentioned, I'm not going to
dictate what goes here, you get to decide.  I was just curious.

> We're planning to normally support partition options
> passed by command line anyway (MTDPARTS).  My understanding is that partition
> options would override these values, right?

Correct.

> The 128M supports quite a few configurations so far (we're sitting at around
> 68M with the bloat of Qt-embedded jammed in there).  This was mostly a line
> in the sand.  Since I will be resubmitting, I might bump it up.  Thanks.

OK.

Kevin

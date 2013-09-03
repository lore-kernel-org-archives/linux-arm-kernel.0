From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 03 Sep 2013 17:15:42 +0100
Subject: 3.11-rc7 big endian - atags and bootloader updates
In-Reply-To: <20130903104027.GB26613@localhost.localdomain>
References: <20130903104027.GB26613@localhost.localdomain>
Message-ID: <52260B2E.3060806@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/13 11:40, Dave Martin wrote:
> On Fri, Aug 30, 2013 at 08:17:56PM +0100, Ben Dooks wrote:
>> This series is to better support older bootloaders, especially the
>> ones that still pass some information in the ATAGS structure used
>> by pre-fdt booting. The series is available at:
>>
>> 	git://git.baserock.org/delta/linux baserock/311-rc7/be/atags-v2
>
> This seems a good idea, but it is a change to the boot protocol which
> may break any existing BE bootloader today.  Are you sure this won't
> cause problems for anyone?

You have to manually select it, so not really.

> One partial solution could be to make the ATAGs endianness-agnostic.
>
> Since the ATAGs start with ATAG core, we know that the word at offset
> <atags base + 4>  must have the value 0x54410001.  If we see a backwards
> value, we know the ATAGs are wrong-endian and every word must must be
> swabbed.

That would be possible, I will look into that.

> What to do about the zImage magic is less clear.  Up to this point,
> BE kernels have always had backwards magic.  Changing the magic might
> upset existing bootloaders, but I've never used a BE be bootloader, so
> I can't really comment on that...

This series uses a specific configuration to change both the ATAG
and magic if the system is meant to be big-endian, but booted on
a little-endian system.

>
> Documentation/arm/Booting should also be updated to reflect any change.
> In fact, what's already there could use clarification, since there is
> no statement about endianness at all yet.

Ok, good idea.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

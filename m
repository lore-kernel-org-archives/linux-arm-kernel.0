From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Feb 2011 18:05:47 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Message-ID: <201102121805.47311.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 February 2011 23:33:42 Andrei Warkentin wrote:
> On Wed, Feb 9, 2011 at 3:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
> 
> cid - 02010053454d3332479070cc51451d00
> csd - d00f00320f5903ffffffffff92404000
> erase_size - 524288
> fwrev - 0x0
> hwrev - 0x0
> manfid - 0x000002
> name - SEM32G
> oemid - 0x0100
> preferred_erase_size - 2097152

Very interesting. So the manfid is the same as on most Kingston cards,
but the oemid is different. Most cards have a two-letter ASCII code
in there, 0x544d ("TM") on Kingston cards, and I always assumed that
this stood for "Toshiba Memory".

What is even stranger is the size value (among other fields) in the CSD,
the card claims a size of exactly 32GB, which I find hard to believe,
given that there are always some bad and reserved blocks.

Are you sure that the card you have is authentic? I've heard a lot about
fake USB sticks advertising a size that is much larger than the actual
flash inside of them.

Also this is the first card that I see advertise an allocation unit
size of 2MB (preferred_erase_size), all other cards seem to advertise
4 MB these days, even if they actually have 2 or 8 MB.

	Arnd

From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 12 May 2015 07:15:38 +0200
Subject: [PATCH] ARM: dts: kirkwood: add "nor-jedec" flash compatible
 binding
In-Reply-To: <20150511132504.GR18496@lunn.ch>
References: <1431066079-19725-1-git-send-email-zajec5@gmail.com>
 <5550AA08.5060001@free-electrons.com>
 <20150511132504.GR18496@lunn.ch>
Message-ID: <CACna6rxb5zuTbJdqrta_220P6QWE4+Z_HEw41NRnZYn1cgjqtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2015 at 15:25, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, May 11, 2015 at 03:09:28PM +0200, Gregory CLEMENT wrote:
>> On 08/05/2015 08:21, Rafa?? Mi??ecki wrote:
>> > Starting with commits
>> > 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
>> > 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
>> > we have "nor-jedec" binding indicating support for JEDEC identification.
>>
>> I have the same question that for mvebu: did you actually check that all
>> the NOR flash referenced in the dts supports the JEDEC identification?
>
> Rafa??, what is the long term plan?

One thing we should do for sure is:
1) Not adding support for new bidnings in the spi-nor driver unless
some chip really needs some special handling
2) Make sure all new entries will include both: specific chip &
generic JEDEC bindings


> Will the device specific property
> be removed sometime in the future, and nor-jedec probing be used to
> identify the device? Is this already the actual behaviour?

Probably not really, because of keeping backward compatibility. Please
mind some out-of-tree DT users and some DTB files being natively on
flashes instead of appended to the kernel. The cost is low, so
probably we can live with that.


> I've seen
> warnings when the DT entry specified the wrong device, something like:
> Found ABC, Expected XYZ.

This happens when DT/platform data provides wrong info about flash
chipset. Driver always queries hardware, even if a flash model was
provided. In case of finding different flash, it prints a warning.

-- 
Rafa?

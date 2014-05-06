From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 May 2014 09:32:26 -0700
Subject: ACPI vs DT at runtime
In-Reply-To: <20140506152725.E5B90C40959@trevor.secretlab.ca>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131118150052.GC24408@sirena.org.uk>
 <20131119091216.GA4412@netboy> <20131120064056.GB5272@netboy>
 <20131121192136.GA16735@n2100.arm.linux.org.uk>
 <20131121204704.E4487C40753@trevor.secretlab.ca>
 <CAHkRjk5MstjD9JFk+co8k89i8geJBmSF6uObhGdmWSe0GJHo8g@mail.gmail.com>
 <97692EF2-013E-4E4B-BC16-E0915D67EFEC@antoniou-consulting.com>
 <53673866.9000105@ahsoftware.de>
 <20140506152725.E5B90C40959@trevor.secretlab.ca>
Message-ID: <CAOesGMi9vGT8hQ-e+nSgM2atg82JZkeCKEDPnM0BdgsWNBGW+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 8:27 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, 05 May 2014 09:06:14 +0200, Alexander Holler <holler@ahsoftware.de> wrote:
>> Am 22.11.2013 13:00, schrieb Pantelis Antoniou:
>>
>> > As one that's going to be dealing with this, please don't take the DTS
>> > files from the kernel.
>> >
>> > If you do this, I can guarantee that within a year almost no ARM board using DT
>> > will boot a mainline kernel.
>> >
>> > The reason is that vendors have enough trouble (and failing) tracking a single
>> > tree, adding yet another will just end to the vendor trees as far as the eye can see.
>> >
>> > Maybe, maybe, EVMs from silicon vendors will still boot, but I doubt any other
>> > customer board will work.
>>
>> A bit late (I don't follow the ML (or what happens in the ARM world)
>> closely, but as I've recently read that ARM64 will go UEFI and ACPI, I
>> wonder what was the reasoning behind that decision.
>
> ARM64 will include support for UEFI an ACPI, but U-Boot and DT are not
> going away. Really the only market segment that will care about ACPI is
> ARM servers. Nobody else (embedded, mobile) needs to worry about it.

I do find it quite interesting to see what is actually launched by
vendors though. The "enterprise" chipsets have not yet shown up. Or,
rather, the only one that is out is X-Gene and it's not SBSA compliant
and thus doesn't fall into the ACPI category.

The AMD announcements yesterday clearly targets their chip to much
broader markets than just enterprise ("high density servers" was the
only market segment that overlaps somewhat with "enterprise" in their
announcements).

So, as Arnd and others have said for a while, it's definitely not a
black and white picture we're looking at. The AMD chips, in
particular, are targeted at mobile and embedded, but they share the
non-CPU part of the SoC with x86. It'd be really interesting to hear
what their plans are for software support of that, but they are so far
absent from any discussions. I really hope they can crawl out of the
woodwork and participate now that the roadmap is made public.


-Olof

From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 15 Apr 2011 21:21:44 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <1302892585.30441.12.camel@dev.znau.edu.ua>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<1302781431.21145.6.camel@dev.znau.edu.ua>
	<BANLkTinvpt5vs+rXd3WN-a2JpGtTV+=Gyg@mail.gmail.com>
	<4DA6E9BD.3090404@hauke-m.de>
	<BANLkTinu+Q367oqQPiUehPcbMs-SBxbwFg@mail.gmail.com>
	<1302786900.21965.52.camel@dev.znau.edu.ua>
	<BANLkTimM8=-pX+Ea8Eyp4XyvP1APbUof9w@mail.gmail.com>
	<1302892585.30441.12.camel@dev.znau.edu.ua>
Message-ID: <BANLkTi=16i+D8frz3X2f+JDtp4hbJKLL3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 15 kwietnia 2011 20:36 u?ytkownik George Kashperko
<george@znau.edu.ua> napisa?:
>> >> Arnd: I found you saying:
>> >> > I believe the one thing we really want from this driver is the bus
>> >> > scan code, which is not present in the amba bus implementation,
>> >> I explained how it works, I believe scanning (EPROM in this case) it
>> >> Broadcom specific, not really AMBA standard. How do you see it?
>> >>
>> > It might not Broadcom specific as EPROM core seems to be CoreLink one
>> > core and maybe is arm-developed. But it isn't documented publicly and we
>> > don't know yet if it is obligatory for all amba (or at least axi)
>> > interconnects or not.
>>
>> Maybe EPROM is not Broadcom specific, but I suspect the content we
>> deal with in bcmai/axi is Broadcom specific. I didn't see any notes of
>> manuf/id/rev/class we deal with. So I guess everything *we* (out
>> driver) read from EPROM is Bcm specific.
>>
>
> Played around amba registers on bcm4716. For all amba cores present
> (under all I mean broadcom ip core agents, oob router core, erom core,
> and other I-dont-know-what-for cores present at 0x18100000). All those
> feature AMBA_CID (0xb105f00d) as PrimeCell ID, and slightly different
> PrimeCell PeripheralIDs:
> * vendor 0xBB, part_number 0x368 for broadcom cores' agents;
> * vendor 0xBB, part_number 0x367 for OOB router core (don't ask me wth
> is this please);
> * vendor 0xBB, part_number 0x366 for EROM core;
>
> ARM vendor id is 0x41. Might 0xBB is Broadcom vendor id but I've found
> no evidence for that with google.

Yeah, as I suspected, everything except Broadcom specific cores
matches AMBA standards quite nicely. Still, I don't see anything in it
we could use for driver.

Let's wait for Russell and Arnd to comment.

-- 
Rafa?

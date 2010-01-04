From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 05 Jan 2010 01:26:06 +0900
Subject: Ethernet / SD Boot
In-Reply-To: <4B3CA02D.9000208@warmcat.com>
References: <20091228192244.GD14799@sirena.org.uk>	<4B390AC3.2060702@warmcat.com>	<20091228202123.GA16524@sirena.org.uk>	<4B391941.6000906@warmcat.com>	<20091228224435.GA23617@sirena.org.uk>	<4B39D439.9070909@warmcat.com>	<20091229123348.GB5784@opensource.wolfsonmicro.com>	<4B39FB2C.4010608@warmcat.com>	<20091230131559.GA369@opensource.wolfsonmicro.com>	<4B3B579E.8030105@warmcat.com>	<20091231122727.GA5613@opensource.wolfsonmicro.com>
	<4B3CA02D.9000208@warmcat.com>
Message-ID: <4B42169E.5040007@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Green wrote:
> On 12/31/09 12:27, Somebody in the thread at some point said:
> 
> Hi -
> 
>> The one I've had the most positive experience with was the BDI2000 - no
>> host software required, it's controlled over the network via telnet (and
>> possibly other things now) for non-debugging activity and provides a GDB
>> stub for debugging.  Like everything else there are plenty of rubbish
>> products out there.
> 
> Sounds pretty good, thanks for the tip.

I pine for the BDI2000 I was lent...

Of course, with bed of nails type systems it is probably possible to
allow the system to boot off what you like, NAND is easily ~18
connections to the board, SD is of course less.

>>>> Assuming the hardware can cope with it, and there's component cost,
>>>> board area and mechanical concerns to address before it gets designed
>>>> in.  There are a lot of systems where it would be useful but there's
>>>> drawbacks you have to bear in mind when pushing it.
>>
>>> I don't really regard those as drawbacks.
>>
>>> Component cost is just the connector and four pullups, I guess it's
>>> $0.70.
>>
>> That 70 cents does rather add up once you start to ship in volume, even
>> a fraction of that would.
> 
> You did notice that you get to save money back from removing NAND and
> JTAG connectors?

A lot of times these are done as 'bed of nails' pads on the PCB so
hardly a bank breaker... Also, see PoP argument below.

> Due to the other advantages of SD Boot basis you can also expect to get
> your product to market quicker, spend less time in the factory, and have
> less returns all of which save money.

And as shown by the nook, make it really easy for your users to root the
thing without trying. You've been spoiled a bit by having an open design
to play with, not everyone likes their users messing with the hardware
once it has left the factory.

Also as another cost item, a lot of the newer cpus with PoP style memory
have some form of NAND/OneNAND built into the system already so adding
an extra SD card is often seen as a waste of extant storage.

> So I wouldn't let this notional $0.70 put you off.
> 
>>> Yeah you need to make the uSD connector accessible if you remove a
>>> cover, that's generally not hard.
>>
>> In some form factors.  In others it's very problematic.
> 
> Dunno how problematic it can be actually, unless you dunk your board in
> epoxy.  uSD connectors are very small footprint and low profile since
> they're widely used in consumer equipment like phones.  Since you only
> need access to it in a crisis due to bricking it, it's OK if you have to
> remove a cover or whatever.  Space shouldn't be an issue due to what it
> allows you to throw out from the board.  I'm sure there are special
> cases but I maintain "generally, that's not hard".

A lot of the time, the bigger manufacturers have enough money that a
commercial JTAG system makes sense, as not only can it program the board
but there are also connectivity checking systems that allow you to do
signal connectiivty testing and other such wonderfullnesses for you.

Smaller vendors tend to cobble together something using open-source
tools, etc.

>>> CPUs in the class where it is useful (ARM11+) all tend to have one
>>> or more SD peripheral unit on the CPU already, so that's for free.
>>
>> Assuming you've not used all the pins for something else, which is again
>> a problem for some classes of device.
> 
> Yeah it's true, if the mux arrangements conflict with other peripheral
> units you must have something's got to give.
> 
> But many chips have 2 or 3 SD units, mux arrangements that bring the
> same things to different pins.  In the case of SD interface, it's a
> given in context of phones where a lot of these chips go, so you tend
> not to find other IO on those balls that is critical and does not also
> appear on other ball muxes.  (It's only 6 balls anyway, it's not like a
> memory bus).  It seems you can typically expect you're going to be able
> to use SD unless you find a specific conflict because the chips are
> deliberately designed to enable SD usage in typical design.

and of course, a lot of modern mobile devices need SD for talking to
other devices, such as WLAN chips, external storage cards, etc. It can
soon take a toll on what is available.

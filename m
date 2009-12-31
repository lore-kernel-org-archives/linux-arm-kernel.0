From: andy@warmcat.com (Andy Green)
Date: Thu, 31 Dec 2009 12:59:25 +0000
Subject: Ethernet / SD Boot
In-Reply-To: <20091231122727.GA5613@opensource.wolfsonmicro.com>
References: <20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
	<4B39FB2C.4010608@warmcat.com>
	<20091230131559.GA369@opensource.wolfsonmicro.com>
	<4B3B579E.8030105@warmcat.com>
	<20091231122727.GA5613@opensource.wolfsonmicro.com>
Message-ID: <4B3CA02D.9000208@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/09 12:27, Somebody in the thread at some point said:

Hi -

> The one I've had the most positive experience with was the BDI2000 - no
> host software required, it's controlled over the network via telnet (and
> possibly other things now) for non-debugging activity and provides a GDB
> stub for debugging.  Like everything else there are plenty of rubbish
> products out there.

Sounds pretty good, thanks for the tip.

>>> Assuming the hardware can cope with it, and there's component cost,
>>> board area and mechanical concerns to address before it gets designed
>>> in.  There are a lot of systems where it would be useful but there's
>>> drawbacks you have to bear in mind when pushing it.
>
>> I don't really regard those as drawbacks.
>
>> Component cost is just the connector and four pullups, I guess it's $0.70.
>
> That 70 cents does rather add up once you start to ship in volume, even
> a fraction of that would.

You did notice that you get to save money back from removing NAND and 
JTAG connectors?

Due to the other advantages of SD Boot basis you can also expect to get 
your product to market quicker, spend less time in the factory, and have 
less returns all of which save money.

So I wouldn't let this notional $0.70 put you off.

>> Yeah you need to make the uSD connector accessible if you remove a
>> cover, that's generally not hard.
>
> In some form factors.  In others it's very problematic.

Dunno how problematic it can be actually, unless you dunk your board in 
epoxy.  uSD connectors are very small footprint and low profile since 
they're widely used in consumer equipment like phones.  Since you only 
need access to it in a crisis due to bricking it, it's OK if you have to 
remove a cover or whatever.  Space shouldn't be an issue due to what it 
allows you to throw out from the board.  I'm sure there are special 
cases but I maintain "generally, that's not hard".

>> CPUs in the class where it is useful (ARM11+) all tend to have one
>> or more SD peripheral unit on the CPU already, so that's for free.
>
> Assuming you've not used all the pins for something else, which is again
> a problem for some classes of device.

Yeah it's true, if the mux arrangements conflict with other peripheral 
units you must have something's got to give.

But many chips have 2 or 3 SD units, mux arrangements that bring the 
same things to different pins.  In the case of SD interface, it's a 
given in context of phones where a lot of these chips go, so you tend 
not to find other IO on those balls that is critical and does not also 
appear on other ball muxes.  (It's only 6 balls anyway, it's not like a 
memory bus).  It seems you can typically expect you're going to be able 
to use SD unless you find a specific conflict because the chips are 
deliberately designed to enable SD usage in typical design.

-Andy

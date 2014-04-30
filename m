From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 21:47:14 +0200
Subject: [PATCH 03/15] ARM: dts: kirkwood: add stdout-path property to
 all boards
In-Reply-To: <20140430163807.GA3082@lunn.ch>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140430163807.GA3082@lunn.ch>
Message-ID: <53615342.8010600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 06:38 PM, Andrew Lunn wrote:
> On Wed, Apr 30, 2014 at 02:56:30PM +0200, Sebastian Hesselbarth wrote:
>> ePAPR allows to reference the device used for console output by
>> stdout-path property. With node labels for Kirkwood UART0, now
>> reference it on all Kirkwood boards that already have ttyS0 in
>> their bootargs property.
> 
> Could this be done in kirkwood.dtsi. I don't think we have any board
> using ttyS1 for console, and if one does come along, it should be able
> to override it.

Yes, we *can* move it in kirkwood.dtsi, but IMHO we *should* keep it in
the board files. I see the "chosen" node and its properties as _the_
board node.

One could argue then, that we should count the memory properties too and
put the most common in the SoC dtsi. But you are right, as UART0 is also
the UART with boot support, it is likely to be always connected to
a more-or-less accessible console output.

I really have no strong opinion about it.

Sebastian

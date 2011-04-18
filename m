From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 18 Apr 2011 17:49:11 +0100
Subject: [PATCHv2 2.6.40 2/3] ARM:simpad: Cleanup CS3 accessors.
In-Reply-To: <4DAC4C2E.3050604@scram.de>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-3-git-send-email-jochen@scram.de>
	<20110418134712.GD2820@pulham.picochip.com>
	<4DAC4C2E.3050604@scram.de>
Message-ID: <20110418164911.GF2820@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 04:35:26PM +0200, Jochen Friedrich wrote:
> Hi Jamie,
> 
> >>- register CS3 as GPIO controller with 24 pins
> >>   (16 output only and 8 input only).
> >
> >I think the basic-mmio-gpio driver (drivers/gpio/basic_mmio_gpio.c)
> >should cover the GPIO controller portion of this (including the
> >shadowing etc).
> 
> I'll have a look at this. Last time I checked, a single virtual address
> for a wite-only/read-only register pair was not supported, but this
> might have changed.

You should just be able to specify a single resource named "dat" and 
you'll be good to go.  The current driver in mainline detects the number 
of GPIO's based on the register width (so it would detect 32 GPIO's in 
your case), but I have some patches posted on lkml that allow this to be 
overridden.  These patches also add support for direction registers 
which it looks like you may need.

Jamie

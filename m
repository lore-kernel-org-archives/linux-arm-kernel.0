From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 19 Apr 2011 10:09:54 +0100
Subject: [PATCHv2 2.6.40 2/3] ARM:simpad: Cleanup CS3 accessors.
In-Reply-To: <4DAC7C9D.7020304@scram.de>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-3-git-send-email-jochen@scram.de>
	<20110418134712.GD2820@pulham.picochip.com>
	<4DAC4C2E.3050604@scram.de>
	<20110418164911.GF2820@pulham.picochip.com>
	<4DAC7C9D.7020304@scram.de>
Message-ID: <20110419090954.GH2820@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 08:02:05PM +0200, Jochen Friedrich wrote:
> Hi Jamie,
> 
> >>I'll have a look at this. Last time I checked, a single virtual address
> >>for a wite-only/read-only register pair was not supported, but this
> >>might have changed.
> >
> >You should just be able to specify a single resource named "dat" and
> >you'll be good to go.
> 
> Not really. The "CS3" register on the simpad device is a 16bit register
> which hat 16 write-only pins and 8 independent read-only pins (no
> direction register, at all). It is implemented using 3 TTL logic
> chips.

Ahh, I misread that bit.

> More information about this strange stuff can be found at:
> http://opensimpad.org/index.php/Wiring#CS3_latch
> 
> I'm not sure if handling such a corner-case in the generic driver makes
> sense.

I think I agree with you - it's more like two gpio_chip's using a single 
register and I would guess that it isn't too common a scenario.

Jamie

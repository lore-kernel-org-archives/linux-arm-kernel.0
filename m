From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 18 Apr 2011 16:35:26 +0200
Subject: [PATCHv2 2.6.40 2/3] ARM:simpad: Cleanup CS3 accessors.
In-Reply-To: <20110418134712.GD2820@pulham.picochip.com>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-3-git-send-email-jochen@scram.de>
	<20110418134712.GD2820@pulham.picochip.com>
Message-ID: <4DAC4C2E.3050604@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

>> - register CS3 as GPIO controller with 24 pins
>>    (16 output only and 8 input only).
>
> I think the basic-mmio-gpio driver (drivers/gpio/basic_mmio_gpio.c)
> should cover the GPIO controller portion of this (including the
> shadowing etc).

I'll have a look at this. Last time I checked, a single virtual address
for a wite-only/read-only register pair was not supported, but this
might have changed.

 > This may need a few other bits (simpad_uart_pm(),
> simpad_map_io() etc) converting over to use the GPIO API though.

Yes. In particular the UART and PCMCIA stuff needs to be converted.
OTOH, this would make some board specific stuff obsolete and would
help to reduce the arch/arm/* mess some more ;-).

Unfortunately, my Simpad doesn't have a PCMCIA slot, so it's hard
for me to test this.

Thanks,
Jochen

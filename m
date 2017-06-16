From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Jun 2017 09:46:11 +0100
Subject: [PATCH v3 0/6] irqchip: meson: add support for the gpio interrupt
 controller
In-Reply-To: <20170615161804.32658-1-jbrunet@baylibre.com>
References: <20170615161804.32658-1-jbrunet@baylibre.com>
Message-ID: <8742df56-42ef-bf70-0ec1-9e8418ec0063@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/17 17:17, Jerome Brunet wrote:
> This patch series adds support for the GPIO interrupt controller found on
> Amlogic's meson SoC families.
> 
> Unlike what the name suggests, this controller is not part of the SoC
> GPIO subsystem. It is a separate controller from which can watch almost
> all pads of the SoC and generate and interrupt from it. Some pins, which
> are not part of the public datasheet, don't seem to have this capability
> though.
> 
> Hardware wise, the controller is a 256 to 8 router with filtering block
> to select edge or level input and the polarity of the signal.  As there
> we can't setup the filtring to generate a signal on both the high and low
> polarity, there is no easy way to support IRQ_TYPE_EDGE_BOTH at the
> moment
> 
> The number of interrupt line routed to the controller depends on the SoC,
> and essentially the number of GPIO available on the SoC.
> 
> This series has been tested on Amlogic S905-P200 board with the front
> panel power button.
> 
> This work is derived from the previous work of Carlo Caione [1].

[...]

So we have two competing series, all based on the same stuff. I must say
this is rather disappointing that people can't manage to collaborate and
work towards a common goal.

I'm going to review the irqchip part, because I've done that on Heiner's
series as well, but that's where I'm going to stop.

Heiner, Jerome: please sort this out between yourselves *BEFORE* sending
any other patch series. This is wasting everybody's time, both yours and
mine (and frankly, this a rather rare commodity these days).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

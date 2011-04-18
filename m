From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 18 Apr 2011 14:47:12 +0100
Subject: [PATCHv2 2.6.40 2/3] ARM:simpad: Cleanup CS3 accessors.
In-Reply-To: <1303131636-19442-3-git-send-email-jochen@scram.de>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-3-git-send-email-jochen@scram.de>
Message-ID: <20110418134712.GD2820@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jochen,

On Mon, Apr 18, 2011 at 03:00:35PM +0200, Jochen Friedrich wrote:
> - prepend CS3 accessors by simpad_ to indicate they
>   are specific to simpad devices.
> - use spinlock to protect shadow register.
> - implement 8 read-only pins.
> - use readl/writel macros so barriers are used where
>   necessary.
> - register CS3 as GPIO controller with 24 pins
>   (16 output only and 8 input only).

I think the basic-mmio-gpio driver (drivers/gpio/basic_mmio_gpio.c) 
should cover the GPIO controller portion of this (including the 
shadowing etc).  This may need a few other bits (simpad_uart_pm(), 
simpad_map_io() etc) converting over to use the GPIO API though.

Jamie

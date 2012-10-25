From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 09:43:43 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <77006526a6de40ddb455b25787b08342.squirrel@ssl.serverraum.org>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc>
 <20121024200128.GY21046@lunn.ch> <20121024233356.1bda95bf@skate>
 <20121025054638.GB8590@lunn.ch> <20121025082826.693939b0@skate>
 <77006526a6de40ddb455b25787b08342.squirrel@ssl.serverraum.org>
Message-ID: <20121025094343.58015440@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael Walle,

On Thu, 25 Oct 2012 09:39:13 +0200, Michael Walle wrote:

> LSXL_GPIO_USB_POWER and LSXL_GPIO_HDD_POWER switches the power on the USB
> and SATA connector. So they are not needed to be set before the driver
> probes, at least in my case here.

Ok.

> But i can imagine boards where you have to enable some kind of
> buffer/muxer/etc which are controlled by GPIO pins. And I don't think that
> should be part of the actual driver, because that would be highly board
> dependant.

You'd have to provide a more specific example so I can imagine how it
will be solved. But for example, if you have a GPIO-controlled muxer
for an I2C bus, then the I2C devices behind the muxer are described as
sub-devices of the muxer, so the probing order is correct.

Of course, I'm not pretending I have ready-to-use solutions for all
situations, but I think we can solve this problem on a case-by-case
basis.

Regardless of those GPIOs, did you solve the hang that happened even
when you removed the gpio_set_value() calls? Or is it still a problem
currently?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

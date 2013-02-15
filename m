From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Feb 2013 11:59:28 +0100
Subject: Sunxi GPIO IRQ handling
Message-ID: <511E1510.70502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have a question for you about how the sunxi support for IRQ on GPIOs.

The IP found on these chip is rather unusual, in the sense that not all
the pins handled by it can trigger an interrupt, but only a small set of
those (32 on the A10, 23 on the A13).

All these pins are not in the same bank, and have to be muxed to a given
function (that is different of the GPIO input function).

You can find more details about this in the IP datasheet found at
http://www.henriknordstrom.net/code/A10/A10%20PIO%20Controller.pdf

I'm not exactly sure about how to integrate this into the
pinctrl/gpio/irqchip infrastructure, if that is achievable.

Do you have any idea on how we could do this?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

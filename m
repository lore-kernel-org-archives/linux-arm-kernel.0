From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 11:02:51 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <1341325365-21393-2-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120705110251.596331e0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

Le Tue,  3 Jul 2012 16:22:34 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> Both IRQ and GPIO controllers can now be represented in DT.  The IRQ
> controllers are setup first, and then the GPIO controllers. Interrupts
> for GPIO lines are placed directly after the main interrupts in the
> interrupt space.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

I have started working on a pinctrl driver for mvebu, which would
handle pin muxing (MPP) + gpio + gpio interrupts.

So far, the pin muxing part is working (needs some polishing, but the
foundation is here), with device tree bindings. I think the pin muxing
could be used for Orion as well.

Now, I'm planning to start working on the gpio + gpio interrupts parts
of the driver, and I'm wondering how to interact with your work on the
matter. My understanding is that the new way of doing a pinmux+gpio
driver is to implement it in drivers/pinctrl/, which I have started
doing.

Should I continue working on a drivers/pinctrl/ driver for mvebu for
Armada 370/XP, and then we see together if it makes sense to extend to
Orion, and if so, what changes are needed?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

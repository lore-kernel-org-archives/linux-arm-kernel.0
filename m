From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 16 Dec 2014 20:20:20 +0100
Subject: [PATCH 2/2] ARM: dts: kirkwood: add dts support for Seagate
 BlackArmor NAS220
In-Reply-To: <20141216163714.GE20170@anne>
References: <20141215203855.GA28940@anne> <20141216085645.GB1450@lunn.ch>
 <20141216163714.GE20170@anne>
Message-ID: <20141216192020.GB12820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The LED can be either one of the two colors or off. Swapping the
> polarity on the two LED pins changes the color.

O.K, so it is using the diode property of a Light Emitting Diode, to
support two colours.

> I am currently playing with the idea to create a multicolor LED kernel 
> driver which is being controlled via GPIOs, but I still have not found 
> the proper abstraction for it.

Maybe multi-colour is too far. Just support bi-colour via two gpios.
Still, it is not so simple. As you said, the led class does not give
too good an abstraction. I guess the best you can do is that when you
turn one on, it automagically turns the other off.

> The point is, that even though this functionality must currently be
> handled by user space (some combination of sysfs writes and a shell
> script) at the moment, the rest of the system is usable.

Sure, we will take the DT file without support for the bicolour
LED. It can be added later.

      Andrew
 

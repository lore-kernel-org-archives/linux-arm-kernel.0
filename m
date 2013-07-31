From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 31 Jul 2013 13:47:44 +0200
Subject: NSA310 + DT
In-Reply-To: <51F8F7E3.9090404@uni-bremen.de>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate> <20130731111414.47e7670b@skate>
 <51F8DC3A.6010007@uni-bremen.de> <20130731115108.21c043fd@skate>
 <51F8F7E3.9090404@uni-bremen.de>
Message-ID: <20130731134744.2d8830f0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Finn Hoffmann,

On Wed, 31 Jul 2013 13:41:23 +0200, Finn Hoffmann wrote:

> I have a question about LED's:
> Is it possible to have the powerled blinking while kernel is loading? 
> Right now all LED's are turned off when the kernel starts.

Yes, you can set a default trigger for GPIO LEDs. Just edit the
kirkwood-nsa310.dts file and add:

	linux,default-trigger	= "heartbeat";

into the GPIO LED that you want to see blinking once the kernel is
running. Note that it won't be blinking while the kernel is loading
(because loading the kernel is done by the bootloader), but it will
start blinking as soon as the kernel has initialized the GPIO LEDs.

> I came across one curious thing: With Andrews kernel I had:
> $ sensors
> adt7476-i2c-0-2e
> Adapter: mv64xxx_i2c adapter
> in0: +1.82 V (min = +0.00 V, max = +3.31 V)
> in1: +1.09 V (min = +0.00 V, max = +2.99 V)
> in2: +3.27 V (min = +2.98 V, max = +3.63 V)
> in3: +5.12 V (min = +4.53 V, max = +5.52 V)
> in4: +11.98 V (min = +0.00 V, max = +15.69 V)
> fan1: 4330 RPM (min = 0 RPM)
> fan2: 0 RPM (min = 0 RPM)
> fan3: 0 RPM (min = 0 RPM)
> fan4: 0 RPM (min = 0 RPM)
> temp1: +32.2??C (low = -127.0??C, high = +127.0??C)
> (crit = +100.0??C, hyst = +96.0??C)
> temp2: +32.5??C (low = -127.0??C, high = +127.0??C)
> (crit = +100.0??C, hyst = +96.0??C)
> temp3: +41.0??C (low = -127.0??C, high = +127.0??C)
> (crit = +100.0??C, hyst = +96.0??C)
> cpu0_vid: +0.000 V
> 
> normally I have:
> # sensors
> lm85-i2c-0-2e
> Adapter: mv64xxx_i2c adapter
> in0: +1.82 V (min = +0.00 V, max = +3.32 V)
> Vcore: +1.07 V (min = +0.00 V, max = +2.99 V)
> +3.3V: +3.25 V (min = +2.97 V, max = +3.63 V)
> +5V: +5.05 V (min = +4.50 V, max = +5.50 V)
> +12V: +12.12 V (min = +0.00 V, max = +15.94 V)
> fan1: 2480 RPM (min = 0 RPM)
> temp1: +35.0?C (low = -127.0?C, high = +127.0?C)
> temp2: +34.0?C (low = -127.0?C, high = +127.0?C)
> temp3: +47.0?C (low = -127.0?C, high = +127.0?C)

I am not sure to understand which one you believe is correct and which
one is wrong, and how the wrong one is wrong. But I don't have much
sensor experience, maybe Andrew has more knowledge than me on this
stuff.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

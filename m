From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Jul 2012 13:19:50 +0200
Subject: [RFC PATCHv3 2/2] ARM: socfpga: Add DTS bindings for Altera's
 SOCFPGA
In-Reply-To: <20120718101316.GB7607@elf.ucw.cz>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-3-git-send-email-dinguyen@altera.com>
 <20120718091617.572070c2@skate> <20120718101316.GB7607@elf.ucw.cz>
Message-ID: <20120718131950.411c3489@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 18 Jul 2012 12:13:16 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> > Are the pdma and gmac0 really specific to the cyclone board? Aren't
> > they similar to the uarts and timers in that they are part of the SoC
> > itself?
> 
> I guess they are not. I'm not dts expert, but would something like
> this be suitable? It boots :-). 

Well, basically, .dtsi files define what is SoC-specific, and the .dts
files defined what is board-specific.

So, things like the internal SoC peripherals will always be same on all
boards that use this SoC (UARTs, timers, Ethernet controllers, I2C
controllers, USB controllers, etc.). These belong to the .dtsi.

Things like external peripherals (devices on I2C/SPI busses) or
additional properties (how the SoC is wired on the board, which pin is
used for this or that). These belong to the .dts.

I don't have the datasheet for your socfpga, so I can't see which
peripherals are internal to the SoC and which are not, especially with
those combined SoC/FPGA designs in which some peripherals can be
synthesized into the FPGA and therefore would probably not belong to
the .dtsi.

So, assuming your Ethernet controller and DMA controller are part of
the SoC itself and will therefore be present on all boards using your
SoC, then the fix you provided looks good.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 Oct 2012 08:32:16 +0100
Subject: [PATCH] Add device tree file for the armadeus apf27
In-Reply-To: <1351626944.55016.YahooMailNeo@web28804.mail.ir2.yahoo.com>
References: <1351268980-25347-1-git-send-email-tremyfr@yahoo.fr>
 <20121029211015.GX1641@pengutronix.de>
 <1351626944.55016.YahooMailNeo@web28804.mail.ir2.yahoo.com>
Message-ID: <20121031073216.GI1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 07:55:44PM +0000, Philippe Reynes wrote:
> 
> 
> Hi Sascha,
> >> +??? ??? osc26m {
> 
> >> +??? ??? ??? compatible = "fsl,imx-osc26m", "fixed-clock";
> >> +??? ??? ??? clock-frequency = <33554432>;
> 
> >Is this really correct? The Datasheet specificies 26MHz, some boards
> >have 27Mhz, but 33?
> 
> The clock value on this board is? 32.768kHz, so 32768 * 1024.
> I've tried others value, all others produce weird behaviour on the serial.

Ok, so your board runs with the 32.768KHz clock input. I didn't know
there are boards that use this as the reference clock. It seems this
is not handled in the current clk code. Could you test the patch I just
sent to the mailing list (Cced you) and provide a Tested-by tag if it
works? The clock frequency provided in the device tree shouldn't make
a difference then anymore. You should specify it to 0 if you have
nothing connected there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

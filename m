From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 17 Aug 2010 07:36:12 +0300
Subject: [PATCH 3/3] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100816141540.GQ27749@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTi=pO-ZJ33FrL=4bVRYa2o9HA0_h5tBYG7wdMuwz@mail.gmail.com>
	<20100816141540.GQ27749@pengutronix.de>
Message-ID: <20100817043612.GA9631@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Aug 16, 2010 at 04:15:40PM +0200, Sascha Hauer wrote:
> On Mon, Aug 16, 2010 at 02:21:06PM +0200, Linus Walleij wrote:
> > 2010/8/16 Sascha Hauer <s.hauer@pengutronix.de>:
> > > The SDMA engine is a scatter/gather DMA engine which is implemented
> > > as a seperate coprocessor. SDMA needs its own firmware which is
> > > requested using the standard request_firmware mechanism. The firmware
> > > has different entry points for each peripheral type, so drivers
> > > have to pass the peripheral type to the DMA engine which in turn
> > > picks the correct firmware entry point from a table contained in
> > > the firmware image itself.
> > 
> > Quite fun, if the spec for the microcode is open this opens up
> > for dynamic firmware generation for specific DMA jobs does it
> > not?
> 
> Unfortunately the specs are not open, so we are sticked to the binary
> microcode from Freescale. I'm pretty sure though that the SDMA engine
> could do at least a device_prep_dma_xor operation.

Chapter 38 in the i.MX25 Reference Manual seems to include almost everything 
there is to know about the SDMA. Isn't this enough for writing custom SDMA 
microcodes?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

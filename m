From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 22 Sep 2010 16:54:42 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100922143406.GT32018@game.jcrosoft.org>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<20100922104846.GQ32018@game.jcrosoft.org>
	<87lj6uavde.fsf@macbook.be.48ers.dk>
	<20100922143406.GT32018@game.jcrosoft.org>
Message-ID: <20100922145442.GA3753@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 22, 2010 at 04:34:06PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:08 Wed 22 Sep     , Peter Korsgaard wrote:
[...]
> > Now, I agree that it would be nice to add an interface to tweak this
> > delay if needed (extra argument to at91_add_device_i2c()?), but that's
> > next to the discussion about what the default should be.
> I'd prefer to calculate it
> 
> so we specify which max freq we want in my mind it will be good to be as in
> spi to specific per device it's max speed so we can adapt the bus freq

sorry in case I got you wrong, but please keep in mind that in
contrast to SPI the addressing in I2C is done via the serial data,
so the bus speed has to be _permanently_ adapted to match the
slowest device present.

Regards,
Wolfgang

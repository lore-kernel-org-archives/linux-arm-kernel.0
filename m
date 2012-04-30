From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 22:47:17 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120430202742.GC28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302209.12482.marex@denx.de> <20120430202742.GC28226@pengutronix.de>
Message-ID: <201204302247.17242.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > > > > This sets the bus to run at 400kHz, prior to this,
> > > > > > the bus frequency was undefined.
> > > > > 
> > > > > Not exactly. The default values let it run at 100kHz.
> > > > 
> > > > Have you tried dumping the default values and comparing it with the
> > > > values for 100kHz in the manual?
> > > 
> > > Yes, sure. Doesn't it work for you? I just rechecked and the values are
> > > okay. That being said, if you make it configurable for 400kHz, it would
> > > in deed be better to rewrite the values for 100kHz, too.
> > 
> > They were different for me ... did you configure the i2c bus in your
> > bootloader possibly? Those values might have been written there since
> > then ... I didn't run i2c in u-boot before booting linux.
> 
> Nope, no I2C involved in the bootloader at all. Do you get the correct
> values after soft-resetting the device?
> 
> It doesn't really matter, though. Just reinit them to the proper values
> depending on the user setting.

Indeed. Default to 100kHz might be a good idea too, in case user entered some 
weird value. Eventually, it'd be nice if we could calculate the timing values 
for all possible frequencies, but I didn't got to deriving such formula ... 
dunno if it's worth it either, doubt so.

Best regards,
Marek Vasut

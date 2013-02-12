From: wolfram@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Feb 2013 11:27:44 +0100
Subject: [PATCH V3] i2c: add bcm2835 driver
In-Reply-To: <5119A7D0.20000@wwwdotorg.org>
References: <1360381978-26092-1-git-send-email-swarren@wwwdotorg.org>
 <20130211225208.GA9893@nekote.pengutronix.de>
 <5119A7D0.20000@wwwdotorg.org>
Message-ID: <20130212102743.GB5490@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> +	ret = wait_for_completion_timeout(&i2c_dev->completion,
> >> +					  BCM2835_I2C_TIMEOUT);
> >> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
> >> +	if (WARN_ON(ret == 0)) {
> >> +		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> >> +		return -ETIMEDOUT;
> >> +	}
> > 
> > I'd suggest to skip the WARN_ON. Timeout is the expected case when you
> > want to read from an EEPROM which is just in the process of
> > erasing/writing data from the previous command.
> 
> I copied that from Tegra. Should that driver be changed too?

The suggestion applies to all drivers, yes :)

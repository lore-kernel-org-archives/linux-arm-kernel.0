From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 13 Sep 2010 18:52:51 +0200
Subject: amba_pl022 spi->mode fix/cleanup patches
In-Reply-To: <AANLkTimtR6+TFX8w1_6MEEqbvk5-StkUTn5kKd4q3DeZ@mail.gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
	<AANLkTimtR6+TFX8w1_6MEEqbvk5-StkUTn5kKd4q3DeZ@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F80AD49D5232@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> 2010/9/10  <wellsk40@gmail.com>:
> 
> > This patch series updates drivers and platforms that depend on the
> > amba_pl022 driver and use the pl022_config_chip structure for
> > setting up the SPI mode and data transfer width.
> 
> I get regressions from the ab8500-spi.c driver from this patch:
> 
> > ssp-pl022 ssp0: ARM PL022 driver, device ID: 0x01080022
> > pl022: mapped registers from 0x80002000 to d0834000
> > ab8500-spi spi0.0: unknown chip, revision: 0x80
> > ab8500-spi: probe of spi0.0 failed with error -22
> 
> The 0x80 above used to be 0x00 before these patches.
> So all of a sudden bit 7 gets set...
> 
> I don't know why this happens, probably some flag that used to
> be set had not been properly propagated in the first patch to alter
> the AB8500 device registration?
> 

I found a bug in the SPI driver for the SPHA field. This would effect
SPI mode 1/3 users. Can you please try it once more with the fix?
(see fix in patch email)
I was hoping these changes would be very minor, but I have limited
hardware to do SPI testing without resorting to loopback mode.

Thanks!
Kevin

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Feb 2016 15:15:16 +0100
Subject: [PATCH 4/4] ARM: davinci: make I2C support optional
In-Reply-To: <56B4A19D.4060307@ti.com>
References: <1454358962-640598-1-git-send-email-arnd@arndb.de>
 <1454358962-640598-5-git-send-email-arnd@arndb.de> <56B4A19D.4060307@ti.com>
Message-ID: <5475182.6SLDQGvbZt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 February 2016 18:50:29 Sekhar Nori wrote:
> > I checked that CONFIG_I2C is still enabled with davinci_all_defconfig,
> > so that does not have to change.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 45b146d746ea ("ARM: Davinci: Fix I2C build errors")
> > Fixes: 22ca466847ad ("davinci: kconfig: select at24 eeprom for selected boards")
> 
> This looks good to me. The #ifdefs in the middle of davinci_evm_init()
> are an eyesore, but getting rid of the selects is a big plus.
> 

I agree on the eyesore. I had an earlier version using "if (IS_BUILTIN(CONFIG_I2C))"
checks that was much nicer, but it didn't work because all the declarations
in include/linux/i2c.h are hidden behind an #ifdef.

I thought about sending a patch for that file too, but I think it has come up
before and was nacked then.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 13:53:52 +0200
Subject: [PATCH 09/10] mtd: st_spi_fsm: Provide mask to obtain correct
 boot device pins
In-Reply-To: <20140522115216.GV6679@lee--X1>
References: <1400757848-18075-1-git-send-email-lee.jones@linaro.org>
 <4231397.Nn7Rm5jh2O@wuerfel> <20140522115216.GV6679@lee--X1>
Message-ID: <6459516.cEryHnqAem@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 12:52:16 Lee Jones wrote:
> > On Thursday 22 May 2014 12:24:07 Lee Jones wrote:
> > > +       /* Mask to apply on boot_device_reg */
> > > +       ret = of_property_read_u32(np, "st,boot-device-msk", &boot_device_msk);
> > > +       if (ret)
> > > +               goto boot_device_fail;
> > > +
> > > 
> > 
> > The binding defines this property as "optional", but the driver fails
> > here if it's not provided. I suggest you add a default value here so you
> > can deal with existing dts. The default should be documented in
> > the binding as well.
> 
> The property is optional. It doesn't fail completely, merely skips the
> boot device check and falls back to using SPI.  I can update the
> documentation to this effect though, no problem.

Ah, I see, thanks for the explanation!

	Arnd

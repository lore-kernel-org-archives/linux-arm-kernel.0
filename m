From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 23 May 2013 09:20:17 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <201305221305.09579.marex@denx.de>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <201305221219.43558.jbe@pengutronix.de> <201305221305.09579.marex@denx.de>
Message-ID: <201305230920.18200.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Vasut wrote:
> > > i2c slowness is a different issue.
> >
> > Same happens here for my i.M23 based platform. It seems the PIO mode does
> > not work, or at least not like it works on a i.MX28. Each short transfer
> > needs about one second (without an error message) but does not send
> > anything on the I2C lines.
> >
> > I need the following patches to make I2C master work within a 3.10-rc2
> > kernel:
> >
> > Subject: [PATCH] I2C/MXS: distinguish i.MX23 and i.MX28 based I2C
>
> I'm all for it, but then ... won't it be better if you actually fixed the
> PIO and mixed-mode on MX23 instead of implementing such hack?

If the PIO mode or my patch is a hack depends on the point of view: Lucas told 
me the PIO mode is *mentioned* but *not specified* in the i.MX23/i.MX28 
datasheets.
So, the PIO mode seems to depend on some undocumented status bits in the 
i.MX28 I2C controller implementation.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |

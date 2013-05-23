From: marex@denx.de (Marek Vasut)
Date: Thu, 23 May 2013 16:48:17 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <201305230920.18200.jbe@pengutronix.de>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <201305221305.09579.marex@denx.de> <201305230920.18200.jbe@pengutronix.de>
Message-ID: <201305231648.17356.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Hi Marek,
> 
> Marek Vasut wrote:
> > > > i2c slowness is a different issue.
> > > 
> > > Same happens here for my i.M23 based platform. It seems the PIO mode
> > > does not work, or at least not like it works on a i.MX28. Each short
> > > transfer needs about one second (without an error message) but does
> > > not send anything on the I2C lines.
> > > 
> > > I need the following patches to make I2C master work within a 3.10-rc2
> > > kernel:
> > > 
> > > Subject: [PATCH] I2C/MXS: distinguish i.MX23 and i.MX28 based I2C
> > 
> > I'm all for it, but then ... won't it be better if you actually fixed the
> > PIO and mixed-mode on MX23 instead of implementing such hack?
> 
> If the PIO mode or my patch is a hack depends on the point of view: Lucas
> told me the PIO mode is *mentioned* but *not specified* in the
> i.MX23/i.MX28 datasheets.

The PIO works the same way DMA does -- set up bits and then pump data into the 
DATA register. 

> So, the PIO mode seems to depend on some undocumented status bits in the
> i.MX28 I2C controller implementation.

How would DMA work then if it used undocumented registers ? It's in the 
documentation, just read it or ask FSL ;-)

Best regards,
Marek Vasut

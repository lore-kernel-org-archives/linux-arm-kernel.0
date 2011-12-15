From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 10:40:44 +0000
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <20111215093218.GN27267@pengutronix.de>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
 <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
 <7FE21149F4667147B645348EC60578850561FF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20111215093218.GN27267@pengutronix.de>
Message-ID: <7FE21149F4667147B645348EC6057885056723@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, December 15, 2011 5:32 PM
> To: Dong Aisheng-B29396
> Cc: Linus Walleij; linus.walleij at stericsson.com; linux-
> kernel at vger.kernel.org; rob.herring at calxeda.com;
> grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; Guo Shawn-R65073
> Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> subsystem
> Importance: High
> 
> On Thu, Dec 15, 2011 at 07:23:42AM +0000, Dong Aisheng-B29396 wrote:
> > > -----Original Message-----
> > > From: Linus Walleij [mailto:linus.walleij at linaro.org]
> > > Sent: Thursday, December 15, 2011 6:16 AM
> > > To: Sascha Hauer
> > > Cc: Dong Aisheng-B29396; linus.walleij at stericsson.com; linux-
> > > kernel at vger.kernel.org; rob.herring at calxeda.com;
> > > grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> > > kernel at pengutronix.de; Guo Shawn-R65073
> > > Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> > > subsystem
> > > Importance: High
> > >
> > > On Wed, Dec 14, 2011 at 10:11 PM, Sascha Hauer
> > > <s.hauer@pengutronix.de>
> > > wrote:
> > > > On Thu, Dec 15, 2011 at 12:03:42AM +0800, Dong Aisheng wrote:
> > >
> > > >> + ? ? pmx = pinmux_get(&pdev->dev, NULL);
> > > >> + ? ? if (IS_ERR(pmx)) {
> > > >> + ? ? ? ? ? ? err = PTR_ERR(pmx);
> > > >> + ? ? ? ? ? ? goto err_pmx_get;
> > > >> + ? ? }
> > > >> + ? ? err = pinmux_enable(pmx);
> > > >> + ? ? if (err)
> > > >> + ? ? ? ? ? ? goto err_pmx_enable;
> > > >> + ? ? imx_data->pmx = pmx;
> > > >> +
> > > >
> > > > Won't this break every i.MX except i.MX6?
> > >
> >
> > If not select PINCTRL, pinmux_enable returns ok by default and
> > pinmux_get Returns NULL which also does not block.
> > So it will not break other i.MX currently since only mx6q are using
> PINCTRL.
> >
> > > Not this patch on its own, first the machines have to select PINCTRL
> > > select PINMUX_FOO
> > >
> > > *Then* it will break :-D
> > >
> >
> > After we move to one single image for mx5 and mx6, it could be an
> > issue Since PINCTRL may be selected by default.
> > So mx5 pinmux driver is in my TODO list.
> 
> Add i.MX3 which is compiled together with i.MX6 :)
> 
Sure, would like to do it.
Thanks

Regards
Dong Aisheng

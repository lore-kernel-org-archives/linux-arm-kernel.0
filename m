From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 08:55:54 +0000
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <CACRpkda-hzrgQ7YttN3Vi3E6jTv-LaQDyAqyJjdvqYDL+C50XA@mail.gmail.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
 <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
 <7FE21149F4667147B645348EC60578850561FF@039-SN2MPN1-013.039d.mgd.msft.net>
 <CACRpkda-hzrgQ7YttN3Vi3E6jTv-LaQDyAqyJjdvqYDL+C50XA@mail.gmail.com>
Message-ID: <7FE21149F4667147B645348EC6057885056487@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Thursday, December 15, 2011 4:29 PM
> To: Dong Aisheng-B29396
> Cc: Sascha Hauer; linus.walleij at stericsson.com; linux-
> kernel at vger.kernel.org; rob.herring at calxeda.com;
> grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; Guo Shawn-R65073
> Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> subsystem
> Importance: High
> 
> On Thu, Dec 15, 2011 at 8:23 AM, Dong Aisheng-B29396
> <B29396@freescale.com> wrote:
> > [Me]
> >> So if you want to do this for i.MX you need something like selectable
> >> dummy pinmuxes, i.e. pinmux_get() to return something that just say
> "OK"
> >> to everything like the dummy regulators.
> >>
> >> Shall I try to create something like that?
> >
> > For those platforms do not select PINCTRL, current code does not block.
> 
> Yeah I know...
> 
> > For platforms do select PINCTRL but does not have pinmux driver ready,
> > for example, single image for both mx5&mx6, IMHO it may be better to
> > fix in driver to avoid introduce too much complexity in pinctrl core.
> 
> If you mean that you fix the i.MX driver for all the combines i.MX
> variants then I agree.
> 
Yes, I mean this one.

> If you mean to do stuff like allow the code to continue even if the
> pinmux isn't found - no. That is not the way we proceed with clocks and
> regulators as Mark has taught me recently, so for consistency we need to
> error out if no pinmux is found.
> 

Regards
Dong Aisheng

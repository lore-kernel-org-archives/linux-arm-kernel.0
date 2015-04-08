From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 08 Apr 2015 15:08:55 +0200
Subject: [PATCH v2 1/9] ata: at91: use syscon to configure the smc
In-Reply-To: <552519B7.2090206@atmel.com>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <3156869.zFaIKVVpHK@amdc1032> <552519B7.2090206@atmel.com>
Message-ID: <1581911.ATyU5YCajb@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, April 08, 2015 02:06:15 PM Nicolas Ferre wrote:
> Le 08/04/2015 14:00, Bartlomiej Zolnierkiewicz a ?crit :
> > On Wednesday, April 08, 2015 01:13:35 PM Alexandre Belloni wrote:
> >> Hi,
> >>
> >> On 08/04/2015 at 13:04:19 +0200, Bartlomiej Zolnierkiewicz wrote :
> >>> On Monday, March 23, 2015 08:29:07 PM Alexandre Belloni wrote:
> >>>> Use syscon/regmap to configure the smc. This allows to avoid using
> >>>> at91sam9_smc.h and to compile the driver in a multiplatform configuration.
> >>>>
> >>>> The driver will still not probe until the proper DT bindings are added. That
> >>>> binding will include an atmel,smc property that is a phandle to the SMC the CF
> >>>> controller is connected to.
> >>>
> >>> If the driver is currently working fine in !ARCH_MULTIPLATFORM
> >>> configuration then this patch will make it non-functional until
> >>> atmel,smc property is added to DT.  To prevent this and preserve
> >>> bisectability the patchset should first add atmel,smc property
> >>> and then convert pata_at91 driver to use it.
> >>>
> >>
> >> Starting with 4.1, it will not be possible to use the driver anyway as
> >> all the platforms using it have switched to multiplatform. This patch
> >> makes it compilable again.
> > 
> > Hmm.  It seems that it was your commit which did the switch without
> > converting all at91 specific code to be multiplatform ready first:
> > 
> >     From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >     Date: Fri, 13 Mar 2015 22:57:18 +0100
> >     Subject: ARM: at91: switch to multiplatform
> > 
> >     Switch AT91 to multiplatform as all SoCs are properly handled.
> > 
> >     Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > ?
> > 
> >> Anyway, it seems that there is little interest in that driver and nobody
> >> I contacted has access to a board which can be used to test this.
> > 
> > If there are no users then probably the driver can be removed but this
> > something that platform Maintainers should decide on.
> 
> This is why there are loose constrains on this driver and that we
> decided to move on.
> 
> So I think that modifying it and introducing the DT property afterwards
> can be done.

OK, thank you for clarifying this.

For pata_at91 changes:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

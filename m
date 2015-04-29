From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 20:23:39 +0200
Subject: [PATCH v7 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <CAL_Jsq+5f_dFJBnQ=vBj7dS8ebqGQe9_5c00CgmA7gT1yp=mZg@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <4492781.xynGhSMMir@wuerfel>
 <CAL_Jsq+5f_dFJBnQ=vBj7dS8ebqGQe9_5c00CgmA7gT1yp=mZg@mail.gmail.com>
Message-ID: <2496827.7XgVanEcLG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 11:57:09 Rob Herring wrote:
> >>
> >
> > I had not looked at the driver before, but I have one comment now:
> >
> > I think this can be simplified to registering a single platform_driver
> > that just matches all four compatible strings, with an appropriate data:
> >
> > +static struct of_device_id xgene_edac_of_match[] = {
> > +       { .compatible = "apm,xgene-edac-mcu", .data = &xgene_edac_mcu_data },
> > +       { .compatible = "apm,xgene-edac-pmd", .data = &xgene_edac_pmd_data },
> > +       { .compatible = "apm,xgene-edac-l3",  .data = &xgene_edac_l3_data },
> > +       { .compatible = "apm,xgene-edac-soc", .data = &xgene_edac_soc_data },
> > +       {},
> > +};
> 
> What exactly is shared here to combine all this into one driver? I
> would argue these are all independent functions and should be separate
> drivers. Add some library functions if there are common parts.

Right, that is probably even better. I was mostly worried about having
multiple platform_driver instances in a single module, which is a bit odd,
and your approach would solve that in a simpler way.

	Arnd

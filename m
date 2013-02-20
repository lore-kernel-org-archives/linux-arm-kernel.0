From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Feb 2013 08:09:56 +0000
Subject: [PATCH 10/35] mfd: ab8500-core: Rework MFD sub-device
 initialisation structures
In-Reply-To: <201302192207.31465.arnd@arndb.de>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-11-git-send-email-lee.jones@linaro.org>
 <201302192207.31465.arnd@arndb.de>
Message-ID: <20130220080956.GA3368@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Feb 2013, Arnd Bergmann wrote:

> On Friday 15 February 2013, Lee Jones wrote:
> > +       {
> > +               .name = "ab8500-charger",
> > +               .of_compatible = "stericsson,ab8500-charger",
> > +               .num_resources = ARRAY_SIZE(ab8500_charger_resources),
> > +               .resources = ab8500_charger_resources,
> > +#ifndef CONFIG_OF
> > +               .platform_data = &ab8500_bm_data,
> > +               .pdata_size = sizeof(ab8500_bm_data),
> > +#endif
> > +       },
> 
> Is this #ifdef correct? I would have expected "#ifdef CONFIG_ATAGS"
> here.

No, it's not correct. See: 23a04f9f40f2b32ee593b768483105b1c776814d

I will fixup when the branched is rebased post-merge.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

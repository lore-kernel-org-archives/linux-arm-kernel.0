From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jun 2017 00:25:23 -0700
Subject: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
In-Reply-To: <810fba3e-a488-fa0d-5639-47f1c76ea2b6@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
 <20170619060256.GK3730@atomide.com>
 <810fba3e-a488-fa0d-5639-47f1c76ea2b6@ti.com>
Message-ID: <20170619072523.GL3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170618 23:37]:
> Hi Tony,
> 
> On Monday 19 June 2017 11:32 AM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
> >> The data manual of J6/J6 Eco recommends to set different IODELAY values
> >> depending on the mode in which the MMC/SD is enumerated in order to
> >> ensure IO timings are met.
> >>
> >> Add support to set the IODELAY values depending on the various MMC
> >> modes using the pinctrl APIs.
> > 
> > This does not seem to apply against Linux next for me for
> > the binding. Fixing that, compile fails for me with:
> > 
> > drivers/mmc/host/omap_hsmmc.c:2384:13: error:
> > 'struct omap_hsmmc_platform_data' has no member named 'version'
> 
> This series has a dependency with
> https://www.spinics.net/lists/arm-kernel/msg586215.html series
> 
> *version* member is added in patch with $subject
> "ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM"

Ah sorry I keep forgetting that. Looks like the only thing
pending with that series is that you were going to send
an update for omap3-overo-base.

BTW, we really should get rid of the mach-omap2/hsmmc.c,
I think overo is the only user for it now.

Regards,

Tony

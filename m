From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jan 2016 08:49:51 -0800
Subject: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
In-Reply-To: <569796EE.7030506@ti.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth> <569796EE.7030506@ti.com>
Message-ID: <20160114164950.GN12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [160114 04:39]:
> On Thursday 14 January 2016 05:37 PM, Sebastian Reichel wrote:
> > 
> > Is there a good reason against adding "depends on REGULATOR_PBIAS"
> > to MMC_OMAP_HS? I guess it's required for most systems and the regulator
> > driver is just 250 loc. I am aware, that this will disable the
> > hsmmc driver for 'make oldconfig', but I guess that will be noticed
> > in a similar way your warning is noticed.
> 
> hmm.. only MMC1 requires PBIAS so I'm not sure if it's okay to add depends on
> REGULATOR_PBIAS for the HSMMC driver as such. And as you said it'll also
> disable the hsmmc driver if oldconfig is used. But do we get a warning?

Adding depends there is a bit wrong, many designs are not using MMC1
but use eMMC on the other controllers instead. I think the runtime
warning is best we can do here to keep things modular.

Regards,

Tony

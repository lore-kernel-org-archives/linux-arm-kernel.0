From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 15:33:01 +0000
Subject: [PATCH v4 2/6] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <20150120150512.GA12209@pengutronix.de>
References: <1419577768-12037-1-git-send-email-flora.fu@mediatek.com>
 <1419577768-12037-3-git-send-email-flora.fu@mediatek.com>
 <20150120144309.GT13701@x1> <20150120150512.GA12209@pengutronix.de>
Message-ID: <20150120153301.GZ13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jan 2015, Sascha Hauer wrote:

> Hi Lee,
> 
> On Tue, Jan 20, 2015 at 02:43:09PM +0000, Lee Jones wrote:
> > On Fri, 26 Dec 2014, Flora Fu wrote:
> > 
> > > Add core files for MT6397 MFD driver.
> > > 
> > > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > > ---
> > >  drivers/mfd/Kconfig                  |  10 +
> > >  drivers/mfd/Makefile                 |   1 +
> > >  drivers/mfd/mt6397-core.c            |  94 +++++++++
> > >  include/linux/mfd/mt6397/core.h      |  23 +++
> > >  include/linux/mfd/mt6397/registers.h | 362 +++++++++++++++++++++++++++++++++++
> > >  5 files changed, 490 insertions(+)
> > >  create mode 100644 drivers/mfd/mt6397-core.c
> > >  create mode 100644 include/linux/mfd/mt6397/core.h
> > >  create mode 100644 include/linux/mfd/mt6397/registers.h
> > 
> > Looks okay.
> > 
> > I assume there are dependancies on this patch.  What are they?
> > 
> > How would you like this set to be handled?
> 
> This patch is outdated, I sent an updated series today (you are on Cc).

Okay, thanks.

> There are no compile time dependencies to the PMIC wrapper, but without
> it the mfd part is pretty useless. I prefer to keep the series together
> and merge it through arm-soc, but I would be fine with merging it
> through mfd aswell.

Yes, everyone feels the same about their cross-subsystem patch-sets. ;)

If there are build-time dependencies I am always happy to take sets
in via MFD and send out pull-requests to other subsystem Maintainers;
however, if there are only run-time dependencies I prefer to save
everyone the hassle and have them go in via their own subsystems.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

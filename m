From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 22:45:17 +0000
Subject: [PATCH v3 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <20140311221938.GO25092@beef>
References: <1394552775-31264-1-git-send-email-mporter@linaro.org>
 <1394552775-31264-3-git-send-email-mporter@linaro.org>
 <20140311160837.GP21216@lee--X1> <20140311221938.GO25092@beef>
Message-ID: <20140311224517.GA5672@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Add a driver for the BCM590xx PMU multi-function devices. The driver
> > > initially supports regmap initialization and instantiation of the
> > > voltage regulator device function of the PMU.
> > > 
> > > Signed-off-by: Matt Porter <mporter@linaro.org>
> > > Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> > > Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > > ---
> > >  drivers/mfd/Kconfig          |  8 ++++
> > >  drivers/mfd/Makefile         |  1 +
> > >  drivers/mfd/bcm590xx.c       | 93 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/bcm590xx.h | 31 +++++++++++++++
> > >  4 files changed, 133 insertions(+)
> > >  create mode 100644 drivers/mfd/bcm590xx.c
> > >  create mode 100644 include/linux/mfd/bcm590xx.h
> > 
> > I have a tiny nit that 'ret' doesn't need to be initialised before
> > use in probe(), but apart from that...
> > 
> > Looks pretty sensible:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Ok, thanks. When I get back in front of my desktop I'll send a v4 of
> just this patch to address that nit. Mark already applied the regulator
> driver from this series, will you be taking this through your tree? For
> that matter, I wonder if the binding would also go through your tree
> with this driver.

At least the MFD portion and the DT binding doc will go through the
MFD tree.

Are there any inter-patch dependencies in the set? If so, we should
know about them so we can coordinate a sensible solution.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

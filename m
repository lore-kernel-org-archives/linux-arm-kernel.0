From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 24 Jul 2015 10:02:03 +0800
Subject: [RESEND PATCH 2/6] soc: Mediatek: Add SCPSYS CPU power domain
 driver
In-Reply-To: <20150623055351.GA22419@pengutronix.de>
References: <srv_scott.shu@mediatek.com>
 <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
 <1434650481-39421-3-git-send-email-scott.shu@mediatek.com>
 <20150623055351.GA22419@pengutronix.de>
Message-ID: <1437703323.11272.12.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-23 at 07:53 +0200, Sascha Hauer wrote:
> Hi Scott,
> 
> On Fri, Jun 19, 2015 at 02:01:17AM +0800, Scott Shu wrote:
> > This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> > MT6580.
> 
> This seems to be support for the very same hardware as I am posting
> here:
> 
> https://lkml.org/lkml/2015/6/22/41
> 
> We should consolidate this.
> 
> My driver is currently handles all power domains except the CPUs while
> yours handles only the CPUs.
> I currently haven't looked whether CPUs can just be part of a power
> domain aswell, but if that works this would probably be the way to go.
> 
> Sascha
> 
> 
Hi Sascga,

We had posted new patch set in following link, but still keep our
original framework.
http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001498.html

As we mentioned in the new email thread, the SMP operations (smp_boot_secondary)
will be executed before registering the scpsys_drv driver, so the CPUs power
domain is controlled on arch/arm/mach-$(MACHINE) directory. 

Please kindly provide your comments and suggestion. Thank you very much. 

Best Regards,
Scott Shu

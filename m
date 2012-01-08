From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 9 Jan 2012 00:38:20 +0100
Subject: [PATCH v4 03/12] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
In-Reply-To: <4F030C2D.3000808@ti.com>
References: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
 <1324565806-31142-4-git-send-email-b-cousson@ti.com>
 <20120102090454.GO18381@ponder.secretlab.ca>
 <4F030C2D.3000808@ti.com>
Message-ID: <20120108233820.GH13679@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Tue, Jan 03, 2012 at 03:09:49PM +0100, Cousson, Benoit wrote:
> On 1/2/2012 10:04 AM, Grant Likely wrote:
> > On Thu, Dec 22, 2011 at 03:56:37PM +0100, Benoit Cousson wrote:
> >> Add initial device-tree support for twl familly chips.
> >> The current version is missing the regulator entries due
> >> to the lack of DT regulator bindings for the moment.
> >> Only the simple sub-modules that do not depend on
> >> platform_data information can be initialized properly.
> >>
> >> Add irqdomain support.
> >>
> >> Add documentation for the Texas Instruments TWL Integrated Chip.
> >>
> >> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >> Cc: Balaji T K<balajitk@ti.com>
> >> Cc: Graeme Gregory<gg@slimlogic.co.uk>
> >> Cc: Samuel Ortiz<sameo@linux.intel.com>
> >> ---
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index f1391c2..f0de088 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -200,6 +200,7 @@ config MENELAUS
> >>   config TWL4030_CORE
> >>   	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> >>   	depends on I2C=y&&  GENERIC_HARDIRQS
> >> +	select IRQ_DOMAIN
> > 
> > As discussed on linux-next, this breaks powerpc.  Drivers cannot select
> > IRQ_DOMAIN, it can only be selected by architectures.  Drivers must depend
> > on it instead.
> 
> OK, good to know. The previous version was already breaking non-ARM platform because the IRQ_DOMAIN was not defined, hence this update.
> I was able to check that this patch was fixing at least x86... but did not have any way to check the PPC build.
> 
> To be honest, I did not fully understand that this flag was there because some arch does not support IRQ domain yet and thus it should be selected at arch level.
> 
> Samuel,
> Here is the updated version, and hopefully the last one, including Grant's fix.
> 
Thanks, I applied it now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

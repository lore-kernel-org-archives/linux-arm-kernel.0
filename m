From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 16 Nov 2016 13:32:32 +0800
Subject: [PATCH 2/3] thermal: hisilicon: fix for dependency
In-Reply-To: <1479212695.2224.12.camel@intel.com>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-3-git-send-email-leo.yan@linaro.org>
 <20161112120534.GC23848@leoy-linaro>
 <1479212695.2224.12.camel@intel.com>
Message-ID: <20161116053232.GA7240@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 08:24:55PM +0800, Zhang Rui wrote:
> On Sat, 2016-11-12 at 20:05 +0800, Leo Yan wrote:
> > Hi Rui, Eduardo,
> > 
> > On Wed, Aug 31, 2016 at 04:50:16PM +0800, Leo Yan wrote:
> > > 
> > > The thermal driver is standalone driver which is used to enable
> > > thermal sensors, so it can be used with any cooling device and
> > > should not bind with CPU cooling device driver.
> > > 
> > > This original patch is suggested by Amit Kucheria; so it's to
> > > polish the dependency in Kconfig, and remove the dependency with
> > > CPU_THERMAL.
> > Could you help review this patch? Or need me resend this patch? Sorry
> > I have not tracked this patches well before, this is one missed
> > patch for 96board Hikey.
> > 
> as it still applies cleanly, the patch is queued for 4.10.

Thanks a lot.

> thanks,
> rui
> > Thanks,
> > Leo Yan
> > 
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > > ?drivers/thermal/Kconfig | 4 +++-
> > > ?1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 2d702ca..91ebab3 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -177,8 +177,10 @@ config THERMAL_EMULATION
> > > ?
> > > ?config HISI_THERMAL
> > > ?	tristate "Hisilicon thermal driver"
> > > -	depends on (ARCH_HISI && CPU_THERMAL && OF) ||
> > > COMPILE_TEST
> > > +	depends on ARCH_HISI || COMPILE_TEST
> > > ?	depends on HAS_IOMEM
> > > +	depends on OF
> > > +	default y
> > > ?	help
> > > ?	??Enable this to plug hisilicon's thermal sensor driver
> > > into the Linux
> > > ?	??thermal framework. cpufreq is used as the cooling device
> > > to throttle

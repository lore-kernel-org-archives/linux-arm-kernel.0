From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 00:08:30 +0200
Subject: [PATCH v2] arm64: defconfig: enable common modules for power
 management
In-Reply-To: <20160908102035.GD1493@arm.com>
References: <1472705469-25599-1-git-send-email-leo.yan@linaro.org>
 <5498297.rN0szKFv4p@wuerfel> <20160908102035.GD1493@arm.com>
Message-ID: <5111815.vFFFHkSD4j@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:20:35 AM CEST Will Deacon wrote:
> Hi Arnd,
> 
> On Thu, Sep 01, 2016 at 09:33:38AM +0200, Arnd Bergmann wrote:
> > On Thursday, September 1, 2016 12:51:09 PM CEST Leo Yan wrote:
> > > Enable common modules for power management; one is to enable
> > > CPUFREQ_DT driver; the driver is used by many platforms by passing OPP
> > > table from device tree.
> > > 
> > > Also enables thermal related drivers. Firstly we need enable
> > > configuration CPU_THERMAL for CPU cooling device driver, this will bind
> > > thermal zone with CPU cooling device; and enable 'power allocator'
> > > thermal governor.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > 
> > 
> > Looks good,
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Catalin and Will: I never know who should merge this kind of patch
> > as we have a number of other arm64 defconfig patches going through
> > arm-soc, but this patch is not really platform specific.
> > 
> > Do you want to pick it up in the arm64 tree or should we take
> > this and others patches like it in general?
> 
> I'm perfectly happy with you taking this, but thanks for asking the
> question. I think that, outside of the architectural bits, it makes
> sense for arm-soc to manage config options that are requested by the
> submaintainers. It also helps reduce defconfig churn. I typically wait
> until -rc1 before making any .config changes, unless they're urgent
> (e.g. systemd suddenly starts needing some options enabled in order to
> boot), so if you queue this for the merge window then we should be good.

Ok, thanks for the detailed answer. I've applied the patch to our
next/arm64 branch now.

	Arnd

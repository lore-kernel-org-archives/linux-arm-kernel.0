From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 16 Nov 2012 06:16:02 +0000
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <20121114102452.GI7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
 <20121114070046.GE7407@opensource.wolfsonmicro.com>
 <50A36DB1.3010706@ti.com> <20121114102452.GI7407@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6D1C4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 15:54:53, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 11:08:49AM +0100, Benoit Cousson wrote:
> 
> > I was wondering that, because exposing a pin to control the whole PMIC
> > low power mode seems to be something that should be generic enough to be
> > handled by the regulator framework.
> 
> Having something that's controlled by software is really not at all
> generic - suspending a PMIC from a GPIO is generally tied in very
> closely with the CPU power sequencing which means it's typically some
> combination of very hard coded things that we can't control or part of
> much wider control of sequencing.
> 
> > In the current situation we do have a pwr_en pin that can be controlled
> > by a GPIO or whatever signal from the SoC.
> > That's very similar, at PMIC level, to the fixedregulator that allow a
> > GPIO binding to enable it.
> 
> > Don't you think that should deserve a support in the fmwk?
> 
> I'm not seeing a coherent description of a feature here - what exactly
> are you proposing that we do?  When and how would this GPIO be set for
> example?

It would be better if these patches are going in like this till the
framework exists. We can change/move this portion once the framework
is defined for this kind.

Thanks
AnilKumar

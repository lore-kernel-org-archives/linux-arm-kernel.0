From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:07:50 +0800
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171226103629.GC11724@b29396-OptiPlex-7040>
References: <20171210120718.15197-1-peng.fan@nxp.com>
 <20171226091230.GP23070@X250>
 <DB6PR04MB3221C1B5362775C72B34B01088060@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171226100344.GA11724@b29396-OptiPlex-7040>
 <DB6PR04MB3221FC8A0E2D6980F8AAB1A288060@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171226102038.GB11724@b29396-OptiPlex-7040>
 <20171226103629.GC11724@b29396-OptiPlex-7040>
Message-ID: <20171227020749.GU23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 06:36:29PM +0800, Dong Aisheng wrote:
> > > > diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-
> > > > imx/cpuidle-imx6sx.c
> > > > index c5a5c3a..edce5bd 100644
> > > > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > @@ -26,7 +26,7 @@ static int imx6sx_idle_finish(unsigned long val)
> > > >          * to adding conditional code for L2 cache type,
> > > >          * just call flush_cache_all() is fine.
> > > >          */
> > > > -       flush_cache_all();
> > > > +//     flush_cache_all();
> > > 
> > > I think flush_cache_all is still needed, to flush L1 data, right?
> > > 
> > 
> > I thought it will be done in generic cpu_suspend.
> > See: __cpu_suspend_save()
> > 
> > So we still need it?
> > 
> 
> Shawn,
> 
> Do you have comments about it?

It seems that there are comments about this flush_cache_all() call right
above it.  To be safe, I would suggest to keep it as it is.

Shawn

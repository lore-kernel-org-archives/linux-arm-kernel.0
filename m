From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 20 Dec 2011 14:59:38 +0100
Subject: [PATCH 0/12] Add clk_prepare/clk_unprepare for mxs clock api
In-Reply-To: <20111220140502.GC5129@S2101-09.ap.freescale.net>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <201112201443.03202.marek.vasut@gmail.com>
 <20111220140502.GC5129@S2101-09.ap.freescale.net>
Message-ID: <201112201459.38868.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Dec 20, 2011 at 02:43:02PM +0100, Marek Vasut wrote:
> > > The mutex locking problem on mxs platform has been reported on mailing
> > > list for a few time.  The cause is that a mutex is being held in mxs
> > > clock api clk_enable/clk_disable which are being called by some mxs
> > > clock client drivers like amba-pl011 and mxs-saif in atomic context.
> > > 
> > > This series takes Russell's suggestion to:
> > >  * Convert all mxs clock client drivers to clk_prepare/clk_unprepare.
> > >  
> > >    (I hope the series has covered all the drivers, but appreciate any
> > >    reminding on any missing ones.)
> > 
> > serial/amba-pl011.c isn't converted, that's where I originally observed
> > the issue.
> 
> The amba-pl011 on mainline had already been converted by Russell.  The
> reason we are still seeing the problem is that clk_prepare/clk_unprepare
> is dummy while clk_enable/clk_disable holds mutex on mxs clock api.
> And this series is trying to swap the their position to have the problem
> fixed.
> 
> You can try this series out to see if your problem goes away :)

Shawn, what exact tree should I use for the test / what branch. I'm slightly 
confused here. So far, I used next/master since it contained all the stuff I 
needed (gpmi nand etc).

Thanks!

M

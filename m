From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jan 2015 11:59:14 +0900
Subject: [PATCH v2] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
In-Reply-To: <20150117011309.GB397@verge.net.au>
References: <1421406528-26704-1-git-send-email-geert+renesas@glider.be>
 <20150117003743.GB15403@verge.net.au>
 <20150117011309.GB397@verge.net.au>
Message-ID: <20150122025913.GK31170@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 10:13:10AM +0900, Simon Horman wrote:
> On Sat, Jan 17, 2015 at 09:37:44AM +0900, Simon Horman wrote:
> > On Fri, Jan 16, 2015 at 12:08:48PM +0100, Geert Uytterhoeven wrote:
> > > Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
> > > MPCore.
> > > 
> > > Without this, there's no clocksource available during early kernel
> > > initialization, before cmt1 is initialized, leading to a lock-up if
> > > CONFIG_CPU_IDLE=y.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > As the TWD driver does not support DT without CCF, this should NOT be
> > > applied to a branch that still has kzm9g-reference support, as this
> > > would lead to another lock-up.
> > > Hence the first choice "dt-for-v3.20" is NOT OK.
> > > "sh73a0-multiplatform-for-v3.20" is OK.
> > > 
> > > v2:
> > >   - The clock is twd_clk
> > 
> > Thanks, for your detailed notes regarding branches.
> > 
> > I plan to push this a little later today. Please take a moment
> > to check that I flowed your advice correctly.
> 
> For reference, I have pushed the above as part of
> renesas-next-20150117-v3.19-rc1.

For the record: Olof has asked for review comments for the BSC driver and
binding patches. Accordingly I have dropped them, and these patches which
depend on them, from next.

This dependency may be due to the way the branches are arranged, rather
than actual dependencies of the code. But regardless I am dropping all
affected branches for now.

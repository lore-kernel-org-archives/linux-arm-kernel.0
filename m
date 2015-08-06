From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 6 Aug 2015 16:46:12 +0800
Subject: [PATCH] ARM: imx6: correct i.MX6 PCIe interrupt routing
In-Reply-To: <1438848690.24317.3.camel@pengutronix.de>
References: <1438793677-19153-1-git-send-email-l.stach@pengutronix.de>
 <20150806012832.GP12927@tiger>
 <1438848690.24317.3.camel@pengutronix.de>
Message-ID: <20150806084612.GF9847@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:11:30AM +0200, Lucas Stach wrote:
> Am Donnerstag, den 06.08.2015, 09:28 +0800 schrieb Shawn Guo:
> > On Wed, Aug 05, 2015 at 06:54:37PM +0200, Lucas Stach wrote:
> > > The PCIe interrupts are also routed through the GPC. This has been
> > > missed from the conversion to stacked IRQ domains as the PCIe
> > > controller uses an explicit interrupt map and thus doesn't inherit
> > > the SoC global interrupt parent.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > So this is a fix and need copy stable?
> > 
> I'm a bit on the fence with this. It only fixes PCIe wake-up and I'm not
> aware of anyone using this functionality and haven't seen any bug
> reports yet.
> 
> On the other hand it is a clear fix and has practically zero chances for
> regressions, so yes please add stable 4.0+ to this.

Applied as a fix, thanks.

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Mar 2014 11:21:29 +0100
Subject: [PATCH 2/3] dts: mpc512x: adjust clock specs for FEC nodes
In-Reply-To: <20140305105209.GZ3327@book.gsilab.sittig.org>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
 <1393237557-31406-2-git-send-email-gsi@denx.de>
 <20140303092231.GS3327@book.gsilab.sittig.org>
 <20140305014836.GC8784@S2101-09.ap.freescale.net>
 <20140305105209.GZ3327@book.gsilab.sittig.org>
Message-ID: <20140306102129.GB17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 11:52:09AM +0100, Gerhard Sittig wrote:
> On Wed, Mar 05, 2014 at 09:48 +0800, Shawn Guo wrote:
> > 
> > On Mon, Mar 03, 2014 at 10:22:31AM +0100, Gerhard Sittig wrote:
> > > On Mon, Feb 24, 2014 at 11:25 +0100, Gerhard Sittig wrote:
> > > > 
> > > > a recent FEC binding document update that was motivated by i.MX
> > > > development revealed that ARM and PowerPC implementations in Linux
> > > > did not agree on the clock names to use for the FEC nodes
> > > > 
> > > > change clock names from "per" to "ipg" in the FEC nodes of the
> > > > mpc5121.dtsi include file such that the .dts specs comply with
> > > > the common FEC binding
> > > > 
> > > > this "incompatible" change does not break operation, because
> > > > - COMMON_CLK support for MPC5121/23/25 and adjusted .dts files
> > > >   were only introduced in Linux v3.14-rc1, no mainline release
> > > >   provided these specs before
> > > > - if this change won't make it for v3.14, the MPC512x CCF support
> > > >   provides full backwards compability, and keeps operating with
> > > >   device trees which lack clock specs or don't match in the names
> > > > 
> > > > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > > 
> > > ping
> > > 
> > > Are there opinions about making PowerPC users of FEC use the same
> > > clock names as ARM users do, to re-use (actually: keep sharing)
> > > the FEC binding?  The alternative would be to fragment the FEC
> > > binding into several bindings for ARM and PowerPC, which I feel
> > > would be undesirable, and is not necessary.
> > 
> > As I already said, Documentation/devicetree/bindings/net/fsl-fec.txt
> > was created specifically for i.MX FEC controller from day one.  And even
> > as of today, it doesn't serve PowerPC, because for example the property
> > 'phy-mode' documented as required one is not required by PowerPC FEC.
> > My opinion would be to patch fsl-fec.txt a little bit to make it clear
> > that it's a binding doc for i.MX FEC, and create the other one for
> > PowerPC FEC.  This is the way less confusing to people and easier for
> > binding maintenance.
> 
> Should we still try to have a common behaviour where possible?
> Such that even if there are two bindings, they don't diverge in
> "unnecessary" ways?

Maybe the long term goal should be to share the code. The MPC5200 FEC
and the i.MX FEC are very similar. Only the DMA engine is quite
different.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

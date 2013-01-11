From: B29397@freescale.com (Chen Peter-B29397)
Date: Fri, 11 Jan 2013 03:06:16 +0000
Subject: [PATCH 1/4] ARM: dts: mxs-phy: Change mxs phy clock usage
In-Reply-To: <20130111022525.GC9139@S2101-09.ap.freescale.net>
References: <1357806954-27960-1-git-send-email-peter.chen@freescale.com>
 <20130111022525.GC9139@S2101-09.ap.freescale.net>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803D63A8D@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> On Thu, Jan 10, 2013 at 04:35:51PM +0800, Peter Chen wrote:
> > For mxs-phy user i.mx6q, the PHY's clock is controlled by
> > hardware automatically, the software only needs to enable it
> > at probe, this clock should be used like below:
> >
> > - Enable at mxs-phy's probe, and disable at mxs-phy's remove, so
> > The clk framework doesn't need to know it. But other mxs-phy user
> > mx28/mx23 may need it, so we give mxs-phy a dummy clock for imx6q.
> > - During the runtime, we don't need to control it.
> >
> Turning it into a dummy clock, you will have no way to maintain the
> use count.  It could possibly cause parent clock be turned off while
> usbphy is in use.
> 
> Let's try to find some other way.
> 
I will keep the phyclk unchanged, but just let it control a reserved bit
In that case, the clk framework will know USB is using PLL.

Meanwhile, the real USB PHY clk gate will only be open one time at
phy driver's probe.

> Shawn

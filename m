From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 29 Jun 2012 20:14:38 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629111334.GB29197@S2101-09.ap.freescale.net>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
 <20120629063329.GE5844@shlinux2.ap.freescale.net>
 <20461.30070.771087.830745@ipc1.ka-ro>
 <20120629093437.GK5844@shlinux2.ap.freescale.net>
 <20461.30991.63507.369439@ipc1.ka-ro>
 <20120629095433.GO5844@shlinux2.ap.freescale.net>
 <20120629111334.GB29197@S2101-09.ap.freescale.net>
Message-ID: <20120629121437.GQ5844@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 07:13:36PM +0800, Shawn Guo wrote:
> On Fri, Jun 29, 2012 at 05:54:33PM +0800, Dong Aisheng wrote:
> > > > > No, that's silly. You would have to change the driver for each
> > > > > new platform that the driver can support.
> > > > > 
> > > > If the new platform is fully compatible with exist platforms, then no.
> > > > If need more clocks, then in either way, we have to add support in driver.
> > > > 
> > > Even if it had fewer clocks you would have to change the driver!
> > > 
> > Yes.
> > For your case, you need create some dummy clock, right?
> > If yes, i would intend to explictly to define it for a new type
> > of IP.
> > 
> I'm with Lothar on this.  At least for imx28 case, we do not even need
> dummy clock, because NULL con_id in clkdev lookup will have all those
> clocks match the only one gpmi-nand clock on imx28, as I already said.
> 
I'm not quite understand. Can you clarify a bit more?
For extra clocks need by mx6q like "gpmi_bch", they're indeed have con_id.
Getting them will not fail on imx28 without dummy clock?

Regards
Dong Aisheng

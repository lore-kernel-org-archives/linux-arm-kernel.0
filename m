From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Apr 2015 20:39:52 +0100
Subject: AM335x OMAP2 common clock external fixed-clock registration
In-Reply-To: <20150417190623.GA24506@deathray>
References: <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com>
 <20150416161756.GA27590@deathray> <55301D7F.30708@gmail.com>
 <20150416220918.GA6057@deathray> <55304486.5020404@gmail.com>
 <20150417020048.GA27174@deathray> <5530CE63.9070508@gmail.com>
 <20150417101833.GU4027@n2100.arm.linux.org.uk>
 <20150417190623.GA24506@deathray>
Message-ID: <20150417193952.GV4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 02:06:23PM -0500, Michael Welling wrote:
> On Fri, Apr 17, 2015 at 11:18:33AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 17, 2015 at 11:12:03AM +0200, Sebastian Hesselbarth wrote:
> > > On 17.04.2015 04:00, Michael Welling wrote:
> > > >On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
> > > >>On 17.04.2015 00:09, Michael Welling wrote:
> > > >>>On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
> > > >>>>On 16.04.2015 18:17, Michael Welling wrote:
> > > [...]
> > > >>>What would be the proper error path?
> > > >>>What cleanup is required?
> > > >>
> > > >>A proper error path would be to release any claimed resource
> > > >>on any error. If you look at the code, the only resources that
> > > >>need to be released are the two clocks in question.
> > > >
> > > >So for every error return in the probe function and in the of si5351_dt_parse
> > > >it needs to clk_put first right?
> > > 
> > > Not quite. The driver should clk_put() every clock that it called a
> > > [of_]clk_get() for. The thing is that clocks can be passed by
> > > platform_data and we never claim them.
> > 
> > I've always said clocks (as in struct clk) should never be passed through
> > platform data.
> >
> 
> What is the alternative for systems that still use the old platform files?

clkdev, which has pre-existed DT.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

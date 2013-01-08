From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 Jan 2013 10:32:38 +0900
Subject: [PATCH v4 00/81] SH pin control and GPIO rework
In-Reply-To: <3937593.RWUOL6AydO@avalon>
References: <1356735303-29474-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1799593.QvyAVKI32y@avalon> <20130107030310.GA14865@verge.net.au>
 <3937593.RWUOL6AydO@avalon>
Message-ID: <20130108013238.GB20866@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 08:33:55PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 07 January 2013 12:03:10 Simon Horman wrote:
> > On Thu, Jan 03, 2013 at 05:40:47PM +0100, Laurent Pinchart wrote:
> > > On Sunday 30 December 2012 09:12:02 Simon Horman wrote:
> > > > [ CC: linux-arm-kernel, Olof Johansson, Arnd Bergmann ]
> > > > 
> > > > On Fri, Dec 28, 2012 at 11:53:42PM +0100, Laurent Pinchart wrote:
> > > > > Hi everybody,
> > > > > 
> > > > > Here's the fourth version of the SH pin control and GPIO rework
> > > > > patches. The patches have been rebased on top of v3.8-rc1 but are
> > > > > otherwise unchanged.
> > > > > 
> > > > > The series starts with the same additional platform-specific fixes as
> > > > > v3 (patches 4 to 7), I would appreciate if someone could review them
> > > > > carefully.
> > > > > 
> > > > > You can get the series from my git tree at
> > > > > 
> > > > >         git://linuxtv.org/pinchartl/fbdev.git pinmux
> > > > > 
> > > > > I would like to push this set to v3.9 independently of the later
> > > > > rework and OF-related sets. Simon, can you take it in your tree ?
> > > > 
> > > > Sure.
> > > > 
> > > > One inconvenience of my tree is that it goes via the arm-soc tree and as
> > > > such things need to be split out into branches. I believe in the case of
> > > > this series the patches will need to be split across soc, board and pfc
> > > > branches. The branches may be based on each other.
> > > > 
> > > > Do you think the following scheme might work:
> > > > 
> > > > Patches 1 - 7: sh-soc
> > > > Patches 8 - 21: pfc, based on sh-soc
> > > > Patches 22 - 29: soc (ARM SoC), based on pfc
> > > > Patches 30 - 42: sh-soc2, based on pfc
> > > > Patches 43 - 50: pfc2, based on a merge of soc and sh-soc2
> > > > Patches 51 - 54: soc2 (ARM SoC), based on pfc2
> > > > Patches 55 - 66: pfc3, based on soc2
> > > > Patches 67 - 78: sh-soc3, based on pfc3
> > > > Patches 79 - 81: pfc4, based on sh-soc3
> > > 
> > > That looks good to me. Alternatively you could base pfc3 on top of a merge
> > > of soc and sh-soc2, and base pfc4 on top of a merge of soc2 and sh-soc3,
> > > but you might get conflicts in Kconfig and Makefile (they should be
> > > trivial to solve though).
> > 
> > Thanks, I have used the modified scheme that you describe above and all
> > seems well. In detail, I have done the following:
> > 
> > Patches 1 - 7: sh-soc based on v3.8-rc1
> > Patches 8 - 21: pfc, based on sh-soc
> > Patches 22 - 29: soc (ARM SoC), based on pfc
> > Patches 30 - 42: sh-soc2, based on pfc
> > Patches 43 - 50 and 55 - 66: pfc2, based on a merge of soc and sh-soc2
> > Patches 51 - 54: soc2 (ARM SoC), based on pfc2
> > Patches 67 - 78: sh-soc3, based on pfc2
> > Patches 79 - 81: pfc4, based on a merge of soc2 and sh-soc-3
> > 
> > Assuming that nothing nasty crops I plan to push the result to
> > the renesas tree later today.
> 
> Thank you.
> 
> Linus acked the next patch series but there are still two issues I need to 
> solve. I'll repost the patches and send a pull request in the near future.

Thanks.

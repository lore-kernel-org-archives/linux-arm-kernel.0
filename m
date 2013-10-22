From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Oct 2013 01:14:10 +0000 (UTC)
Subject: [PATCH 02/11] ARM: OMAP3: clock: add API to enable/disable
 autoidle for a single clock
In-Reply-To: <alpine.DEB.2.02.1310211250370.13878@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1310191712450.11676@utopia.booyaka.com>
 <20131021122610.11944.71616@quantum>
 <alpine.DEB.2.02.1310211250370.13878@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1310220113530.6442@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Oct 2013, Paul Walmsley wrote:

> On Mon, 21 Oct 2013, Mike Turquette wrote:
> 
> > Quoting Paul Walmsley (2013-10-19 10:16:50)
> > > On Fri, 11 Oct 2013, Tero Kristo wrote:
> > > 
> > > > Some drivers require direct access to the autoidle functionality of the
> > > > interface clocks. Added clock APIs for these, so that the drivers do not
> > > > need to access CM registers directly.
> > > > 
> > > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > 
> > > Thanks, queued.  Please coordinate with Mike to get 
> > > allow_idle/deny_idle-type interfaces into the Common Clock Framework, so 
> > > these can be replaced with standard CCF-type allow_idle() & deny_idle() 
> > > functions.  That interface should include use-counting so multiple callers 
> > > can use allow_idle() and deny_idle() without stomping on each other.
> > 
> > Where and when are these functions called? IIRC these are only accessed
> > at boot/init time, though I may be wrong. If they are a boot-time thing
> > then the .init callback provided in struct clk may be sufficient.
> 
> They are called dynamically at runtime when the McBSP goes active and 
> inactive.  It's in the next patch in this series.  I'm fairly sure at 
> least one other IP block needs this workaround also.

By the way, here's that patch:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg97004.html

- Paul

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 01:10:42 +0100
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <alpine.LFD.2.20.1509071152510.22877@knanqh.ubzr>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
 <1713935.2YV1sNJUyb@wuerfel>
 <alpine.LFD.2.20.1509071152510.22877@knanqh.ubzr>
Message-ID: <20150908001042.GT21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 03:40:36PM -0400, Nicolas Pitre wrote:
> On Mon, 7 Sep 2015, Arnd Bergmann wrote:
> 
> > On Thursday 03 September 2015 21:24:00 Nicolas Pitre wrote:
> > > If 768MB targets were common place then it could be worth changing the 
> > > default vmalloc size to accommodate this memory size and testing all the 
> > > other targets to make sure no regressions are introduced.  But given it 
> > > is easy to change the default via the kernel cmdline, and that you lose 
> > > only 8 MB otherwise, I don't think it is worth the trouble and/or the 
> > > risk.
> > 
> > Agreed.
> 
> Well... I think there is a better solution.

Doesn't this clash with things like:

#define UNCACHEABLE_ADDR        0xff000000      /* IRQ_STAT */

?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

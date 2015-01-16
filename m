From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Jan 2015 08:21:20 -0800
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <20150115171924.GV11502@n2100.arm.linux.org.uk>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
Message-ID: <20150116162119.GK18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 09:22]:
> On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > > I don't think we've proven a link there.  While you're right that it
> > > causes the wrong interrupt to be claimed, I have two kernels here,
> > > both claim the same interrupt, one which is multi-platform and issues
> > > that strange warning, and one which targets only OMAP4 which doesn't.
> > > 
> > > There's something else going on which causes the bus errors which we
> > > haven't found.
> > 
> > I think it gets triggered if you enable PREEMPT.
> 
> That's something which we can try to prove... build running now with
> CONFIG_PREEMPT=y

Looks like you now have the omap_l3_noc error appear for sdp4430 in
your logs after enabling PREEMPT.

I guess that means case closed for this one?

Regards,

Tony

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jan 2015 17:19:24 +0000
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <20150115152838.GB18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
Message-ID: <20150115171924.GV11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > I don't think we've proven a link there.  While you're right that it
> > causes the wrong interrupt to be claimed, I have two kernels here,
> > both claim the same interrupt, one which is multi-platform and issues
> > that strange warning, and one which targets only OMAP4 which doesn't.
> > 
> > There's something else going on which causes the bus errors which we
> > haven't found.
> 
> I think it gets triggered if you enable PREEMPT.

That's something which we can try to prove... build running now with
CONFIG_PREEMPT=y

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

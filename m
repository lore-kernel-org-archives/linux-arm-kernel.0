From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Sep 2014 16:40:40 +0200
Subject: [PATCH 0/4] ARM: mvebu: minor Armada 370 RD improvements
In-Reply-To: <20140911142655.GB30828@titan.lakedaemon.net>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140911134323.GB29780@lunn.ch>
 <20140911160000.55a4de80@free-electrons.com>
 <20140911142601.GA30828@titan.lakedaemon.net>
 <20140911142655.GB30828@titan.lakedaemon.net>
Message-ID: <20140911144040.GC29780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Since debian does modular builds on a regular basis, maybe they have
> > some recommendations.
> > 
> > My thought is that I doubt we're the only SoC family with this issue.
> > To avoid the maintenance headache of extra _mod_defconfig's, perhaps we
> > could add a ./scripts/config toggle to turn the current .config enabled
> > tristates into modules?

As Thomas pointed out, that is probably the easy bit. We need a test
system which has access to these modules, and udev in order to get
them loaded. Do any of the current boot farms support this?

What might be possible is to work on top of the new test initiative,
kicked off at the last summit.  That is going to need a more capable
rootfs, so might provide a usable basis. We also need some tests, so
that once we have finished booting, do we at least have all the
devices we expect in /sys. That would of at least found the recent SPI
FLASH breakage.

      Andrew

From: w@1wt.eu (Willy Tarreau)
Date: Wed, 24 Feb 2016 19:41:14 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160129114853.GQ10826@n2100.arm.linux.org.uk>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
Message-ID: <20160224184114.GB2292@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 29, 2016 at 11:48:53AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2016 at 08:45:12PM +0100, Willy Tarreau wrote:
> > On Wed, Jan 27, 2016 at 07:31:44PM +0000, Russell King - ARM Linux wrote:
> > (...)
> > > > For example, on the Armada 388 GP, the board has two ports, labelled
> > > > GE0 and GE1. One has to know that GE0 is eth1 and GE1 is eth0, which
> > > > isn't really obvious.
> > > > 
> > > > In order to solve this, this patch proposes to exceptionaly violate
> > > > the rule of "order DT nodes by register address", and put the 0x70000
> > > > node before the 0x30000 node, so that network interfaces get named in
> > > > a more natural way.
> > > 
> > > The danger is that this will completely mess up people's existing
> > > scripts/distro configuration which are now used to the current
> > > labelling of the network ports.
> > > 
> > > Not every distro provides a sane way to deal with this...
> > 
> > Well, may be that's one more reason for fixing it before boards start to
> > ship and run distro kernels. If some boards are already in the wild running
> > on a BSP kernel, people will complain that mainline reorders their network
> > ports and will stick to the BSP kernel instead.
> 
> I've checked, and we believe not many people are using mainline kernels
> on clearfog.  I'll have to adjust my debian jessie setup to fix the
> resulting carnage though.  On the plus side, it means that mainline
> matches Marvell's kernel for interface naming.

Well, now I'm one of these and I confirm that it's really painful to
have a different ordering between the DTB provided in mainline and the
DTB provided with the board. The worst thing is that using mainline,
eth0 corresponds to the switch and appears up, so you don't immediately
realize that it's not where your cable is connected :-/

Thus could we please get Thomas' patch to ensure that the board boots
with similar interface naming with both the original and mainline kernel ?

Thanks in advance,
Willy

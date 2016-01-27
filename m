From: w@1wt.eu (Willy Tarreau)
Date: Wed, 27 Jan 2016 20:45:12 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160127193143.GF10826@n2100.arm.linux.org.uk>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
Message-ID: <20160127194512.GA16638@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 07:31:44PM +0000, Russell King - ARM Linux wrote:
(...)
> > For example, on the Armada 388 GP, the board has two ports, labelled
> > GE0 and GE1. One has to know that GE0 is eth1 and GE1 is eth0, which
> > isn't really obvious.
> > 
> > In order to solve this, this patch proposes to exceptionaly violate
> > the rule of "order DT nodes by register address", and put the 0x70000
> > node before the 0x30000 node, so that network interfaces get named in
> > a more natural way.
> 
> The danger is that this will completely mess up people's existing
> scripts/distro configuration which are now used to the current
> labelling of the network ports.
> 
> Not every distro provides a sane way to deal with this...

Well, may be that's one more reason for fixing it before boards start to
ship and run distro kernels. If some boards are already in the wild running
on a BSP kernel, people will complain that mainline reorders their network
ports and will stick to the BSP kernel instead.

Just my two cents,
Willy

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 22:37:37 +0100
Subject: [PATCH] keystone: adds cpu_die implementation
In-Reply-To: <20150629212814.GE7557@n2100.arm.linux.org.uk>
References: <1435600352-32733-1-git-send-email-vitalya@ti.com>
 <20150629175223.GC19863@leverpostej> <559191E0.4080808@ti.com>
 <20150629212814.GE7557@n2100.arm.linux.org.uk>
Message-ID: <20150629213737.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 10:28:14PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2015 at 02:43:44PM -0400, Vitaly Andrianov wrote:
> > 
> > 
> > On 06/29/2015 01:52 PM, Mark Rutland wrote:
> > >On Mon, Jun 29, 2015 at 06:52:32PM +0100, Vitaly Andrianov wrote:
> > >>This commit add cpu_die implementation
> > >>
> > >>Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> > >>---
> > >>
> > >>The discussion of the "keystone: psci: adds cpu_die implementation" commit
> > >>shows that if PCSI is enabled platform code doesn't need that implementation
> > >>at all. Having PSCI commands in DTB should be sufficient. Unfortunately
> > >>Keystone with LPAE enable requires some additional development.
> > >
> > >I don't follow.
> > >
> > >What do you need to implement for LPAE?
> > Hi Mark,
> > 
> > The Keystone platform needs to set ttbr1 when it boots secondary core.
> > It is done in the keystone_smp_secondary_initmem(), which is
> > .smp_secondary_init member of the keystone_smp_ops. I couldn't find a way
> > how I can add similar function to psci_smp_ops.
> 
> TTBR1 will be set by generic code.  You don't need to do anything special
> now that my fixes for TI's horrid physical address space switch are in.
> (you may remember, you tested the patches...)

Oh, it was Murali who tested it, not yourself.  Sorry.  Suggest you
dig out the patches either from mainline (they're in Linus' tip) or
ask Murali for them...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

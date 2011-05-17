From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 17 May 2011 11:13:09 +0300
Subject: [PATCH v5 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <20110517074348.GA26669@n2100.arm.linux.org.uk>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
	<1305610643.2630.15.camel@localhost>
	<1305611178.2630.21.camel@localhost>
	<20110517074348.GA26669@n2100.arm.linux.org.uk>
Message-ID: <1305619989.2630.31.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 08:43 +0100, Russell King - ARM Linux wrote:
> On Tue, May 17, 2011 at 08:46:18AM +0300, Artem Bityutskiy wrote:
> > On Tue, 2011-05-17 at 08:37 +0300, Artem Bityutskiy wrote:
> > > Sorry if this sounds like an attack, it is not. I just think that we
> > > carry crap for too long and should start forcing people to clean it up
> > > by not accepting changes :-)
> > 
> > Sorry, I forgot to note that I do not insist that you have to re-work
> > MTD partitions support - you already do a very good thing by killing a
> > redundant driver, and delaying this would be counter-productive. But I
> > anyway wanted to express my thoughts.
> 
> So, what's happening with this patch set?  I'd like to have an ack from
> the MTD people for the set.

David should answer, but from my POW the patches are OK. The "#ifdef
CONFIG_MTD_AFS_PARTS" is ugly. I think it can be just killed, it just
needs an additional patch to silence the kernel (completely untested,
Marc, could you please check it?):

From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jun 2014 21:03:35 +0800
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617102519.GC13808@arm.com>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617101606.GE23430@n2100.arm.linux.org.uk>
 <20140617102123.GA13808@arm.com>
 <20140617102344.GG23430@n2100.arm.linux.org.uk>
 <20140617102519.GC13808@arm.com>
Message-ID: <20140617130333.GE8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 11:25:20AM +0100, Will Deacon wrote:
> On Tue, Jun 17, 2014 at 11:23:44AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jun 17, 2014 at 11:21:23AM +0100, Will Deacon wrote:
> > > I think that actually works ok, because writing zeroes doesn't actually
> > > do anything as far as I understand. The problem with suspend/resume is
> > > that the suspend/resume cycle could well clear the internal state and
> > > writing zeroes won't re-enable the workaround bits.
> > > 
> > > I'll double-check this with the hardware guys, since this register really
> > > is undocumented.
> > 
> > Are you saying that it is write one to set, and writing zero is ignored?
> > If that's true, we should simplify the work-around code to get rid of the
> > read-modify-write.
> 
> That's my understanding for the diagnostic register, but I've asked for
> clarification internally.

Hmm, I'm not sure that's the case.  On imx6q, I can read out diagnostic
register as 0x00200850 which matches the errata we enable.

Shawn

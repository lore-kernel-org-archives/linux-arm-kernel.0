From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 11:16:06 +0100
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617095729.GF13020@arm.com>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
Message-ID: <20140617101606.GE23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:57:29AM +0100, Will Deacon wrote:
> On Tue, Jun 17, 2014 at 09:31:18AM +0100, Shawn Guo wrote:
> > Hi Will, Catalin,
> > 
> > The CP15 diagnostic register holds some bits for ARM errata workaround.
> > Since core gets power gated across suspend/resume cycle, these bits will
> > get lost along the way.  Is it okay for errata workaround to continue
> > working after suspend, or do we have to save/restore diagnostic register
> > to keep workaround effective?
> 
> I'm not sure that saving/restoring the diagnostic register on A9 actually
> works at all (I seem to remember some bits always read as zero?).

If that's true, then we have a problem.  We always read-modify-write
this register when enabling work-arounds.  If it always reads as
zero, then enabling a subsequent work-around will disable the
previous work-around.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

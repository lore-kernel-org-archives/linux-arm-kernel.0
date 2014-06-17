From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jun 2014 22:02:46 +0800
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617130827.GF8860@dragon>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617130827.GF8860@dragon>
Message-ID: <20140617140245.GB7299@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 09:08:28PM +0800, Shawn Guo wrote:
> On Tue, Jun 17, 2014 at 10:57:29AM +0100, Will Deacon wrote:
> > On Tue, Jun 17, 2014 at 09:31:18AM +0100, Shawn Guo wrote:
> > > Hi Will, Catalin,
> > > 
> > > The CP15 diagnostic register holds some bits for ARM errata workaround.
> > > Since core gets power gated across suspend/resume cycle, these bits will
> > > get lost along the way.  Is it okay for errata workaround to continue
> > > working after suspend, or do we have to save/restore diagnostic register
> > > to keep workaround effective?
> > 
> > I'm not sure that saving/restoring the diagnostic register on A9 actually
> > works at all (I seem to remember some bits always read as zero?).
> > 
> > Anyway, I'd expect the state could be lost, so you'd need to reprogram
> > the diagnostic register rather than save/restore its value.
> 
> Yes, we observed that diagnostic state gets lost after suspend.  But
> per my testing I can see the effectiveness of errata workaround
> preserves.  Is this expected somehow or something wrong in my testing?

It is something wrong in my testing.  The effectiveness of errata
workaround goes off together with diagnostic register state.

Shawn

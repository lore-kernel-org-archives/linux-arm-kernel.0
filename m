From: simon@sequanux.org (Simon Guinot)
Date: Mon, 7 Nov 2011 16:12:33 +0100
Subject: [PATCH] ARM: kirkwood: add LaCie Network Space Lite v2 support
In-Reply-To: <20111107144200.GQ12913@n2100.arm.linux.org.uk>
References: <1320661790-7066-1-git-send-email-cvubrugier@lacie.com>
 <20111107103506.GN12913@n2100.arm.linux.org.uk>
 <20111107143959.GC18750@kw.sim.vm.gnt>
 <20111107144200.GQ12913@n2100.arm.linux.org.uk>
Message-ID: <20111107151233.GD18750@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 02:42:00PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 03:39:59PM +0100, Simon Guinot wrote:
> > Hi Russel,
> > 
> > On Mon, Nov 07, 2011 at 10:35:06AM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 07, 2011 at 11:29:50AM +0100, Christophe Vu-Brugier wrote:
> > > > +#ifdef CONFIG_MACH_NETSPACE_LITE_V2
> > > > +MACHINE_START(NETSPACE_LITE_V2, "LaCie Network Space Lite v2")
> > > > +	.atag_offset	= 0x100,
> > > > +	.init_machine	= netspace_v2_init,
> > > > +	.map_io		= kirkwood_map_io,
> > > > +	.init_early	= kirkwood_init_early,
> > > > +	.init_irq	= kirkwood_init_irq,
> > > > +	.timer		= &kirkwood_timer,
> > > 
> > > When the restart series is queued, you'll have to add a:
> > > 	.restart	= kirkwood_restart,
> > > 
> > > here.
> > > 
> > > Please also order these initializers in the same order as they're
> > > declared in struct machine_desc - the order there reflects the order in
> > > which they're called.  They're done like that to aid peoples
> > > understanding of the ordering there.
> > > 
> > > So you want .init_machine after .timer.
> > 
> > The Christophe's patch is consistent with the other Kirkwood machines
> > declarations. Maybe that all this declarations should be fixed with a
> > separate patch ?
> 
> Why create more work (and churn) by having to fix new introductions up?
> Why not make sure new introductions are correct first time around.

Yes, sure. On the other hand, having different field ordering for the
machine_desc declarations within a same file could confuse the reader
as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111107/8620abf9/attachment.sig>

From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 03 Apr 2012 09:35:37 -0600
Subject: [PATCH] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <4F7AC8A8.9020606@arm.com>
References: <1333384217-13441-1-git-send-email-marc.zyngier@arm.com>
 <4F7AC138.9020308@citrix.com> <4F7AC8A8.9020606@arm.com>
Message-ID: <20120403153538.0D1B83E044A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Apr 2012 10:53:44 +0100, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 03/04/12 10:22, David Vrabel wrote:
> 
> Hi David,
> 
> > On 02/04/12 17:30, Marc Zyngier wrote:
> >> The GICv2 can have virtualization extension support, consisting
> >> of an additional set of registers and interrupts. Add the necessary
> >> binding to the GIC DT documentation.
> > 
> > The Xen hypervisor's device tree support is very much incomplete so I've
> > not looked into this is much detail.
> > 
> > Would it make more sense to extend the existing gic binding with the the
> > additional information rather than adding a new node?
> 
> I'm actually torn between the two approaches. On one side, the VGIC is
> part of the GIC spec, hence should be part of the GIC node. On the other
> hand, it is logically handled by a different piece of software (the
> hypervisor), and would normally be probed separately. Having a separate
> node makes the probing more sensible.

Don't get too hung up on the software side of things.  Describe it in
a way that makes sense for the hardware.  There is lots of precidence
for two hunks of software initializating from the same node; either by
probe kicking off two init hooks, or by early init code going looking
for the node manually.

g.

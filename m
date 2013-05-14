From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 00:07:54 +0200
Subject: [PATCH 1/3] ARM: shmobile: irqpin: fix handling of spurious
 interrupts in DT case
In-Reply-To: <20130328053044.GA25938@verge.net.au>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
 <20130327104747.GE3040@verge.net.au> <20130328053044.GA25938@verge.net.au>
Message-ID: <9440947.bdAq5SKB5F@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 14:30:45 Simon Horman wrote:
> On Wed, Mar 27, 2013 at 07:47:47PM +0900, Simon Horman wrote:
> > On Thu, Mar 21, 2013 at 05:05:36PM +0100, Guennadi Liakhovetski wrote:
> > > To disable spurious interrupts, that get triggered on certain hardware,
> > > the irqpin driver masks them on the parent interrupt controller. To
> > > specify such broken devices a .control_parent parameter can be provided
> > > in the platform data. In the DT case we need a property, to do the same.
> > > However, this is not enough to correctly handle spurious interrupts in
> > > the DT case. In the non-DT case all interrupts get mapped statically
> > > during probing, therefore, if a spurious interrupt arrives, it can
> > > easily be mapped back to hardware registers and bits and handled. In the
> > > DT case interrupts are mapped only when a device, using that interrupt
> > > is instantiated from DT. So, spurious interrupts occur unmapped and thus
> > > cannot be handled properly. This patch fixes this by mapping such
> > > interrupts as they occur.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Thanks, queued up for v3.10 in the intc-external-irq branch of the renesas
> > tree.
>
> As requested by Magnus I have dropped this patch.

I'm running into similar spurious interrupt issues on both kzm9g-reference and 
marzen-reference. Magnus, you've rejected this patch, how would you like the 
issue to be fixed ? Could you please provide a patch ? This is blocking 
pinctrl DT testing, as I can't get any board to boot properly through DT with 
ethernet support.

-- 
Regards,

Laurent Pinchart

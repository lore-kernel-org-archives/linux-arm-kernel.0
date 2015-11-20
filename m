From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 16:42:11 +0000
Subject: [Xen-devel] [PATCH 07/13] ARM: Xen: Document UEFI support on
 Xen ARM virtual platforms
In-Reply-To: <564B59F3.2060801@citrix.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-8-git-send-email-shannon.zhao@linaro.org>
 <564B59F3.2060801@citrix.com>
Message-ID: <alpine.DEB.2.02.1511201640550.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, David Vrabel wrote:
> On 17/11/15 09:57, shannon.zhao at linaro.org wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > Add a "uefi" node under /hypervisor node in FDT, then Linux kernel could
> > scan this to get the UEFI information.
> [...]
> > --- a/Documentation/devicetree/bindings/arm/xen.txt
> > +++ b/Documentation/devicetree/bindings/arm/xen.txt
> > @@ -15,6 +15,24 @@ the following properties:
> >  - interrupts: the interrupt used by Xen to inject event notifications.
> >    A GIC node is also required.
> >  
> > +To support UEFI on Xen ARM virtual platforms, Xen pupulates the FDT "uefi" node
> > +under /hypervisor with following parameters:
> 
> It's not really clear why this is under /hypervisor and why xen needs to
> define its own nodes.

There was a very long discussion about this, see http://marc.info/?l=xen-devel&m=144321258920213


> The handling of the existing linux standard nodes can be made
> Xen-specific by the presence of the /hypervisor/compatible == "xen" node
> (or similar), right?
> 
> > +________________________________________________________________________________
> > +Name                      | Size   | Description
> > +================================================================================
> > +xen,uefi-system-table     | 64-bit | Physical address of the UEFI System Table.
> > +--------------------------------------------------------------------------------
> > +xen,uefi-mmap-start       | 64-bit | Physical address of the UEFI memory map.
> > +--------------------------------------------------------------------------------
> 
> I would probably say "Guest physical address..." just to be clear.
> 
> > +xen,uefi-mmap-size        | 32-bit | Size in bytes of the UEFI memory map
> > +                          |        | pointed to in previous entry.
> > +--------------------------------------------------------------------------------
> > +xen,uefi-mmap-desc-size   | 32-bit | Size in bytes of each entry in the UEFI
> > +                          |        | memory map.
> > +--------------------------------------------------------------------------------
> > +xen,uefi-mmap-desc-ver    | 32-bit | Version of the mmap descriptor format.
> > +--------------------------------------------------------------------------------
> 
> Need a reference to the mmap descriptor format here.
> 
> David
> 

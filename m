From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 Aug 2012 17:18:29 +0100
Subject: [PATCH 20/24] xen: update xen_add_to_physmap interface
In-Reply-To: <20120801145215.GP7227@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-20-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120801145215.GP7227@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1208011716040.4645@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Aug 2012, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 26, 2012 at 04:34:02PM +0100, Stefano Stabellini wrote:
> > Update struct xen_add_to_physmap to be in sync with Xen's version of the
> > structure.
> > The size field was introduced by:
> > 
> > changeset:   24164:707d27fe03e7
> > user:        Jean Guyader <jean.guyader@eu.citrix.com>
> > date:        Fri Nov 18 13:42:08 2011 +0000
> > summary:     mm: New XENMEM space, XENMAPSPACE_gmfn_range
> > 
> > According to the comment:
> > 
> > "This new field .size is located in the 16 bits padding between .domid
> > and .space in struct xen_add_to_physmap to stay compatible with older
> > versions."
> > 
> > This is not true on ARM where there is not padding, but it is valid on
> > X86, so introducing size is safe on X86 and it is going to fix the
> > interace for ARM.
> 
> Has this been checked actually for backwards compatibility? It sounds
> like it should work just fine with Xen 4.0 right?
> 
> I believe this also helps Mukesh's patches, so CC-ing him here for
> his Ack.
> 
> I can put this in right now in tree if we are 100% sure its compatiblie with 4.0.

Yes, it is: 4 bytes integers are 4-byte aligned on 32 bit and 64 bit
on x86.

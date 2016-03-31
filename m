From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 31 Mar 2016 16:21:45 +0100 (BST)
Subject: [Xen-devel] [PATCH v7 12/17] ARM64: ACPI: Check if it runs on
 Xen to enable or disable ACPI
In-Reply-To: <20160331144418.GR27408@perard.uk.xensource.com>
References: <20160331144418.GR27408@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1603311620260.31571@sstabellini-ThinkPad-X230>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Mar 2016, Mark Rutland wrote:
> On Thu, Mar 31, 2016 at 01:44:08PM +0200, Ard Biesheuvel wrote:
> > The heuristic is there to decide whether some DTB image contains a
> > complete description of the platform, or only some data handed over by
> > the bootloader. Arguably, a DT containing both /chosen and /hypervisor
> > but nothing else can still not describe an actual platform, and
> > whether we execute under Xen or not is completely irrelevant.
> 
> I disagree somewhat.
> 
> In general, a /hypervisor node may not be a Xen node, and could
> potentially imply some platform description. As /hypervisor is a generic
> name up for grabs by any hypervisor, we simply cannot make assumptions
> about it.
> 
> As /chosen is a special reserved path that implies a particular binding
> and has no compatible string, so checking its path alone is correct.
> 
> While we do check that the /hypervisor node is "xen,xen" compatible
> elsewhere, the canonical mechanism of checking for a Xen node (as
> opposed to any hypervisor's node) is to check the compatible string.
> 
> If we are going to handle nodes for other hypervisors while treating the
> DTB as empty, we need code and discussion regarding said hypervisor.
> 
> Hence, for checking for a Xen /hypervisor node, I would prefer we
> checked the compatible string rather than the path.
> 
> An is_xen_node() helper (which could also check that the path is
> "/hypervisor") would avoid having redundant, subtly distinct ways of
> checking, and would explicitly document precisely what we are checking
> for.

That's also OK for me.

From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 9 Nov 2012 07:50:33 -0500
Subject: [Xen-devel] BUG: ARM build failures due to Xen
In-Reply-To: <201211081745.06518.arnd@arndb.de>
References: <20121106175749.GO28327@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1211081544510.2689@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1211081554220.2689@kaball.uk.xensource.com>
 <201211081745.06518.arnd@arndb.de>
Message-ID: <20121109125033.GA30634@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 05:45:06PM +0000, Arnd Bergmann wrote:
> On Thursday 08 November 2012, Stefano Stabellini wrote:
> > From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > 
> > xen/arm: Fix compile errors when drivers are compiled as modules.
> > 
> > We end up with:
> > 
> > ERROR: "HYPERVISOR_event_channel_op" [drivers/xen/xen-gntdev.ko] undefined!
> > ERROR: "privcmd_call" [drivers/xen/xen-privcmd.ko] undefined!
> > ERROR: "HYPERVISOR_grant_table_op" [drivers/net/xen-netback/xen-netback.ko] undefined!
> > 
> > and this patch exports said function (which is implemented in hypercall.S).
> > 
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I guess it's best to merge that through the Xen tree.

applied.

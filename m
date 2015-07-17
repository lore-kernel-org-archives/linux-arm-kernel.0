From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 17 Jul 2015 14:37:38 +0100
Subject: [Xen-devel] [PATCH v2 14/20] xen/grant-table: Make it running
 on 64KB granularity
In-Reply-To: <55A7DA8F.2040805@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-15-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161643380.17378@kaball.uk.xensource.com>
 <55A7DA8F.2040805@citrix.com>
Message-ID: <alpine.DEB.2.02.1507171436000.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 16/07/2015 16:47, Stefano Stabellini wrote:
>  >> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> > > index 3679293..0a1f903 100644
> > > --- a/drivers/xen/grant-table.c
> > > +++ b/drivers/xen/grant-table.c
> > 
> > The arm part is fine, but aren't you missing the change to RPP and SPP?
> 
> SPP has been removed by commit 548f7c94759ac58d4744ef2663e2a66a106e21c5 as it
> was unused.
> 
> For RPP, it's used internally so there is no need to switch to XEN_PAGE_SIZE.
> Otherwise we will waste 60KB for each internal page allocated (see
> gnttab_init).

I see now that RPP is specifically for internal data structures in
grant-table.c and it is used consistently.

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

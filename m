From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 11 Aug 2014 11:41:00 +0100
Subject: master build: 1 failures 16 warnings (v3.16-8695-ga7d7a14)
In-Reply-To: <20140811100041.GM15344@arm.com>
References: <E1XFj9r-0003ZJ-40@cassiel.sirena.org.uk>
 <20140808143227.GR17528@sirena.org.uk> <20140811100041.GM15344@arm.com>
Message-ID: <alpine.DEB.2.02.1408111140060.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Aug 2014, Will Deacon wrote:
> On Fri, Aug 08, 2014 at 03:32:27PM +0100, Mark Brown wrote:
> > On Fri, Aug 08, 2014 at 01:20:31PM +0100, Build bot for Mark Brown wrote:
> > 
> > > Failed defconfigs:
> > > 	arm64-allmodconfig
> > #
> > > Errors:
> > 
> > > 	arm64-allmodconfig
> > > ../arch/arm64/xen/../../arm/xen/grant-table.c:53:5: error: conflicting types for 'arch_gnttab_init'
> > 
> > This build failure which was present in -next has now appeared in Linus'
> > tree too.  It appears to be the result of a mismerge, we have two
> > definitions of the function, one from b7dd0e350e0bd (x86/xen: safely map
> > and unmap grant frames when in atomic context) with the old signature
> > and one from 438b33c7145ca8a5131 (xen/grant-table: remove support for V2
> > tables).
> 
> Stefano, Konrad: do you have a fix queued for this? I don't think there's a
> lot I can do from the arm64 side.

Will, I am aware of the issue. David should come up with a fix today.
Otherwise I'll take care of it.

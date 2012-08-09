From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 9 Aug 2012 12:54:24 -0400
Subject: [PATCH v2 10/23] xen/arm: compile and run xenbus
In-Reply-To: <alpine.DEB.2.02.1208081836050.21096@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
 <1344263246-28036-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120807182157.GN15053@phenom.dumpdata.com>
 <50216228.7010407@tycho.nsa.gov>
 <alpine.DEB.2.02.1208081743430.21096@kaball.uk.xensource.com>
 <50229B70.3090507@tycho.nsa.gov>
 <alpine.DEB.2.02.1208081805520.21096@kaball.uk.xensource.com>
 <5022A303.709@tycho.nsa.gov>
 <alpine.DEB.2.02.1208081836050.21096@kaball.uk.xensource.com>
Message-ID: <20120809165424.GA7220@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Right, the original patch didn't break anything with PV domains. The case
> > it doesn't handle is an HVM initial domain with an already-running
> > Xenstore domain; I think this applies both to ARM and hybrid/PVH on x86.
> > In that case, usage would be set to LOCAL instead of HVM.
> 
> 
> Right, however if I am not mistaken there is no such thing as an HVM
> dom0 right now on x86 and hybrid/PVH is probably going to return true on
> xen_pv_domain() and false on xen_hvm_domain().

The other way around.  HVM = true, PV = false.

Mukesh, correct me if I am wrong pls.
> 
> In the ARM case, given that we don't have a start_info page, we would
> need another way to figure out whether a xenstore stub domain is already
> running, so I think we can just postpone the solution of that problem
> for now.

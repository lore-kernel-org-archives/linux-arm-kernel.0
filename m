From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 Aug 2012 16:50:59 +0100
Subject: [PATCH 08/24] xen/arm: Introduce xen_pfn_t for pfn and mfn types
In-Reply-To: <20120801142249.GF7227@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-8-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120801142249.GF7227@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1208011646560.4645@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Aug 2012, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 26, 2012 at 04:33:50PM +0100, Stefano Stabellini wrote:
> > All the original Xen headers have xen_pfn_t as mfn and pfn type, however
> > when they have been imported in Linux, xen_pfn_t has been replaced with
> > unsigned long. That might work for x86 and ia64 but it does not for arm.
> 
> How come?

see below

> > Bring back xen_pfn_t and let each architecture define xen_pfn_t as they
> > see fit.
> 
> I am OK with this as long as your include a comment in both of the
> interface.h saying why this is needed. I am curious why 'unsinged long'
> won't work? Is it b/c on ARM you always want a 64-bit type?

Yes, we would like to make the same interface work for 32 and 64
bit guests, without any need for a "compat layer" as we currently have
on x86.
In fact I am going to add another patch to explicitly size all the
other unsigned long that we have in the public interface.

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jun 2015 17:12:11 +0100
Subject: [Xen-devel] [RFC 23/23] arm/xen: Add support for 64KB page
 granularity
In-Reply-To: <55897517.9000306@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-24-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1506231508050.16917@kaball.uk.xensource.com>
 <55896F2D.5030405@citrix.com>
 <alpine.DEB.2.02.1506231545370.18681@kaball.uk.xensource.com>
 <55897517.9000306@citrix.com>
Message-ID: <alpine.DEB.2.02.1506231711250.18681@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Julien Grall wrote:
> On 23/06/15 15:49, Stefano Stabellini wrote:
> > Yes, you are right, I was reading an older version of Linux that still
> > had xen_remap_domain_mfn_range properly implemented.
> > 
> > The new function is called xen_remap_domain_mfn_array which calls
> > xen_xlate_remap_gfn_array.
> > 
> > I'll rephrase my question then: What about xen_remap_domain_mfn_array? I
> > guess we don't support that use case on 64K guests? If so, I would
> > appreaciate an assert and/or an error message.
> 
> See https://lkml.org/lkml/2015/5/14/563

Ah, that's fantastic! In that case:

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 6 Nov 2013 16:21:09 +0000
Subject: [PATCH] arm,arm64: Conditionalize bio_vec usage
In-Reply-To: <20131106152909.GE979@arm.com>
References: <1383743117-4138-1-git-send-email-treding@nvidia.com>
 <20131106152909.GE979@arm.com>
Message-ID: <alpine.DEB.2.02.1311061619540.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Nov 2013, Catalin Marinas wrote:
> On Wed, Nov 06, 2013 at 01:05:17PM +0000, Thierry Reding wrote:
> > Commit 3d1975b57097 (arm,arm64: do not always merge bio_vec if we are
> > running on Xen) unconditionally added code using the bio_vec typedefs
> > which causes build errors on configurations where CONFIG_BLOCK is
> > disabled.
> 
> I guess this commit is only in -next. Would it have the same hash when
> hitting mainline? Otherwise I'm fine with the patch, maybe Stephano can
> pick it together with the patch that breaks it.

I sent this patch earlier today to fix the problem:

http://marc.info/?l=linux-kernel&m=138374169030300&w=2

I prefer it to adding more ifdefs. I was going to add it to linux-next
as soon as possible and then send it upstream together with the rest of
the series.

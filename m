From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 23 Nov 2016 09:48:47 +0000
Subject: [PATCHv3 5/6] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <92635df6-9a58-02cf-3230-1a84c28370d1@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-6-git-send-email-labbott@redhat.com>
 <20161118143543.GC1197@leverpostej>
 <92635df6-9a58-02cf-3230-1a84c28370d1@redhat.com>
Message-ID: <20161123094847.GC24624@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 09:40:06AM -0800, Laura Abbott wrote:
> On 11/18/2016 06:35 AM, Mark Rutland wrote:
> > On Thu, Nov 17, 2016 at 05:16:55PM -0800, Laura Abbott wrote:
> >>  	/* Grab the vDSO code pages. */
> >>  	for (i = 0; i < vdso_pages; i++)
> >> -		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
> >> +		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa_symbol(&vdso_start)) + i);
> > 
> > Nit: phys_to_page() again.
> 
> I think it makes sense to keep this one as is. It's offsetting
> by pfn number and trying force phys_to_page would make it more
> difficult to read.

My bad; I failed to spot the + i.

That sounds good to me; sorry for the noise there.

Thanks,
Mark.

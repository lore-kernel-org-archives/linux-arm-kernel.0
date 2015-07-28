From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 28 Jul 2015 14:06:21 -0700
Subject: [PATCH 0/8] Use correctly the Xen memory terminologies in Linux
In-Reply-To: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55B7EECD.8050605@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 08:02 AM, Julien Grall wrote:
> Hi all,
> 
> This patch series aims to use the memory terminologies described in
> include/linux/mm.h [1] for Linux xen code.
> 
> Linux is using mistakenly MFN when GFN is meant, I suspect this is because the
> first support of Xen was for PV. This has brought some misimplementation
> of memory helpers on ARM and make the developper confused about the expected
> behavior.
> 
> For instance, with pfn_to_mfn, we expect to get a MFN based on the name.
> Although, if we look at the implementation on x86, it's returning a GFN.
> Most of the callers are also using it this way.
> 
> The first 2 patches of this series is ARM related in order to remove
> PV specific helpers which should not be used and fixing the implementation of
> pfn_to_mfn.
> 
> The rest of the series is here rename most of the usage in the common code
> of MFN to GFN. I also took the opportunity to replace most of the call to
> pfn_to_gfn in the common code by page_to_gfn avoid construction such
> as pfn_to_gfn(page_to_pfn(...).
> 
> Note the one xen-blkfront will be dropped by 64K series [2], I can include it
> if necessary.
> 

Can we actually get some documentation for Xen before starting to change
names around?

	-hpa

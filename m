From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:45:11 -0600
Subject: [PATCH v2 22/22] ARM: dma-mapping: Drop GFP_COMP for DMA memory
 allocations
In-Reply-To: <1373021097-32420-23-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-23-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E853D7.4070200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> arm_iommu_alloc_attrs wants to split pages after allocation in order
> to reduce the memory footprint. This does not work well with GFP_COMP
> pages, so drop this flag before allocation.
> 
> (ref: ea2e7057c0234cfb8b09467d8f137760d371fc72)

Include the commit description too, so people have a clue what that
commit is.

Presumably this fix can go through the core ARM tree independently from
this series? Or, will this series cause problems if applied without this
patch being applied first?

BTW, I don't see anything in this series that adds the mandatory
properties to DT for all this to work. I assume if I just apply this
series, everything will blow up? If so, it's usual to say "[PATCH RFC"
rather than "[PATCH" in the email subject.

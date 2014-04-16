From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 16:25:58 +0200
Subject: [PATCH 0/2] ARM SMMU fixes
In-Reply-To: <20140416142206.GB2005@arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <15544035.e9eK8n7TO4@avalon> <20140416142206.GB2005@arm.com>
Message-ID: <13460694.iQzMW2ZBpY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 16 April 2014 15:22:06 Will Deacon wrote:
> On Tue, Apr 15, 2014 at 04:55:07PM +0100, Laurent Pinchart wrote:
> > Hi Will,
> 
> Hi Laurent,
> 
> > On a different but related topic, I've written an ipmmu-vmsa.c driver for
> > a Renesas IOMMU. The IP core has custom registers but uses VMSA-compatible
> > page tables. What would you think about sharing the page table management
> > code between the two drivers ? The biggest difference between the two
> > implementations is that I've hardcoded the long descriptor format, while
> > you have reused more system MMU macros that make the arm-smmu driver use
> > 2 or 3 levels of page tables depending on whether LPAE is disabled or
> > enabled.
>
> Actually, my driver also only supports the long-descriptor format, so the
> code should be shareable. Things I support that you might have issues with
> are:
> 
>  - Stage-1 and Stage-2 formats (although long-descriptor only)
>  - 4k and 64k pages (the latter for arm64 only)
>  - Contiguous pte hints
> 
> Do you have support for section mappings in your driver? That is something
> I'd be keen to add for the ARM SMMU, but it really complicates the code.

I have pending patches for that, I still need to clean them up. I'll try to 
post them in the next few days and I'll CC you. Discussing the implementation 
will be easier with the code, so I propose resuming this thread in response to 
the patches.

-- 
Regards,

Laurent Pinchart

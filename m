From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 15:22:06 +0100
Subject: [PATCH 0/2] ARM SMMU fixes
In-Reply-To: <15544035.e9eK8n7TO4@avalon>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <53440057.6020703@arm.com> <20140414165858.GI12916@arm.com>
 <15544035.e9eK8n7TO4@avalon>
Message-ID: <20140416142206.GB2005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 04:55:07PM +0100, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> On a different but related topic, I've written an ipmmu-vmsa.c driver for a 
> Renesas IOMMU. The IP core has custom registers but uses VMSA-compatible page 
> tables. What would you think about sharing the page table management code 
> between the two drivers ? The biggest difference between the two 
> implementations is that I've hardcoded the long descriptor format, while you 
> have reused more system MMU macros that make the arm-smmu driver use 2 or 3 
> levels of page tables depending on whether LPAE is disabled or enabled.

Actually, my driver also only supports the long-descriptor format, so the
code should be shareable. Things I support that you might have issues with
are:

 - Stage-1 and Stage-2 formats (although long-descriptor only)
 - 4k and 64k pages (the latter for arm64 only)
 - Contiguous pte hints

Do you have support for section mappings in your driver? That is something
I'd be keen to add for the ARM SMMU, but it really complicates the code.

Will

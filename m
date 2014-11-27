From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Thu, 27 Nov 2014 14:43:00 +0200
Subject: [RFC PATCH 0/4] Genericise the IOVA allocator
In-Reply-To: <cover.1416931258.git.robin.murphy@arm.com>
References: <cover.1416931258.git.robin.murphy@arm.com>
Message-ID: <54771C54.5080100@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Robin Murphy wrote:
> Hi all,
>
> I've been implementing IOMMU DMA mapping for arm64, based on tidied-up
> parts of the existing arch/arm/mm/dma-mapping.c with a clear divide
> between the arch-specific parts and the general DMA-API to IOMMU-API layer
> so that that can be shared; similar to what Ritesh started before and was
> unable to complete[1], but working in the other direction.
>
> The first part of that tidy-up involved ripping out the homebrewed IOVA
> allocator and plumbing in iova.c, necessitating the changes presented here.
> The rest is currently sat under arch/arm64 for the sake of getting it
> working quickly with minimal impact - ideally I'd move it out and port
> arch/arm before merging, but I don't know quite how impatient people are.
> Regardless of that decision, this bit stands alone, so here it is.
>
> Feel free to ignore patches 1 and 2, since I see Sakari has recently
> posted a more thorough series for that[2], that frankly looks nicer ;)
> I've merely left them in as context here.

Thank you. Could you review the set, please? I've gotten no comments on 
it so far.

You probably wouldn't need the 4th patch, and probably this isn't the 
right list to get that forward anyway.

> [1]:http://thread.gmane.org/gmane.linux.ports.arm.kernel/331299
> [2]:http://article.gmane.org/gmane.linux.kernel.iommu/7436

-- 
Kind regards,

Sakari Ailus
sakari.ailus at linux.intel.com

From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 26 Jul 2017 13:08:07 +0200
Subject: [PATCH v2 0/4] Optimise 64-bit IOVA allocations
In-Reply-To: <cover.1500636791.git.robin.murphy@arm.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
Message-ID: <20170726110807.GN15833@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin.

On Fri, Jul 21, 2017 at 12:41:57PM +0100, Robin Murphy wrote:
> Hi all,
> 
> In the wake of the ARM SMMU optimisation efforts, it seems that certain
> workloads (e.g. storage I/O with large scatterlists) probably remain quite
> heavily influenced by IOVA allocation performance. Separately, Ard also
> reported massive performance drops for a graphical desktop on AMD Seattle
> when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
> ops domain getting initialised differently for ACPI vs. DT, and exposing
> the overhead of the rbtree slow path. Whilst we could go around trying to
> close up all the little gaps that lead to hitting the slowest case, it
> seems a much better idea to simply make said slowest case a lot less slow.

Do you have some numbers here? How big was the impact before these
patches and how is it with the patches?


	Joerg

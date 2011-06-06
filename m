From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 6 Jun 2011 12:09:51 +0200
Subject: [RFC 0/6] iommu: generic api migration and grouping
In-Reply-To: <1307053663-24572-1-git-send-email-ohad@wizery.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
Message-ID: <20110606100950.GC30762@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 02, 2011 at 06:27:37PM -0400, Ohad Ben-Cohen wrote:
> First stab at iommu consolidation:
> 
> - Migrate OMAP's iommu driver to the generic iommu API. With this in hand,
>   users can now start using the generic iommu layer instead of calling
>   omap-specific iommu API.
> 
>   New code that requires functionality missing from the generic iommu api,
>   will add that functionality in the generic framework (e.g. adding framework
>   awareness to multi page sizes, supported by the underlying hardware, will
>   avoid the otherwise-inevitable code duplication when mapping a memory
>   region).

The IOMMU-API already supports multiple page-sizes. See the
'order'-parameter of the map/unmap functions.

>   Further generalizing of iovmm strongly depends on our broader plans for
>   providing a generic virtual memory manager and allocation framework
>   (which, as discussed, should be separated from a specific mapper).

The generic vmm for DMA is called DMA-API :) Any reason for not using
that (those reasons should be fixed)?

>   iovmm has a mainline user: omap3isp, and therefore must be maintained,
>   but new potential users will either have to generalize it, or come up
>   with a different generic framework that will replace it.

Moving to the DMA-API should be considered here. If it is too much work
iovmm can stay for a while, but the goal should be to get rid of it and
only use the DMA-API.

> - Create a dedicated iommu drivers folder (and put the base iommu code there)

Very good idea.


	Joerg

P.S.: Please also Cc the iommu-list (iommu at lists.linux-foundation.org)
      in the future for IOMMU related patches.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

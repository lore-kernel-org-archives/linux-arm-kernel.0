From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 6 Jun 2011 18:15:30 +0300
Subject: [RFC 0/6] iommu: generic api migration and grouping
In-Reply-To: <20110606100950.GC30762@amd.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<20110606100950.GC30762@amd.com>
Message-ID: <BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Mon, Jun 6, 2011 at 1:09 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> The IOMMU-API already supports multiple page-sizes. See the
> 'order'-parameter of the map/unmap functions.

This is insufficient; users need somehow to tell what page sizes are
supported by the underlying hardware (we can't assume host page-sizes,
and we want to use bigger pages whenever possible, to relax the TLB
pressure).

>> ? Further generalizing of iovmm strongly depends on our broader plans for
>> ? providing a generic virtual memory manager and allocation framework
>> ? (which, as discussed, should be separated from a specific mapper).
>
> The generic vmm for DMA is called DMA-API :) Any reason for not using
> that (those reasons should be fixed)?

This is definitely something we will look into (dspbridge will need it
too, not only omap3isp).

Thanks,
Ohad.

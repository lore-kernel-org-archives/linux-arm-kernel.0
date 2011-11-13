From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sun, 13 Nov 2011 10:43:46 +0900
Subject: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
In-Reply-To: <4EBDD426.4050105@codeaurora.org>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org>
 <20111110170918.GE13213@amd.com> <4EBC3E20.20301@codeaurora.org>
 <20111111132411.GH13213@amd.com> <4EBDD426.4050105@codeaurora.org>
Message-ID: <CAHQjnOPkhR2SWO5Tov_V6Zw=zYb9EOJPbC1bENXJ+ttw_TB1HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 11:04 AM, Stepan Moskovchenko
<stepanm@codeaurora.org> wrote:
> Yes, the scatterlist is allowed to have different page sizes. But, they are
> required to have a length that is a multiple of 4K. If a page in the list is

An element in scatterlist may not be aligned by 4K but I think IOMMU driver
must round it up to 4K if IOMMU API support iommu_map_range().

The first element in scatterlist is often not aligned by 4K if the pages are
provided from userspace. Length + offset of  the element must be
aligned by 4K, though.

Thank you,
KyongHo.

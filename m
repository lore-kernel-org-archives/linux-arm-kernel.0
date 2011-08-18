From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 18 Aug 2011 09:33:43 +0300
Subject: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
In-Reply-To: <20110818.082716.383880091385751705.Hiroshi.DOYU@nokia.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-5-git-send-email-ohad@wizery.com>
	<20110818.082716.383880091385751705.Hiroshi.DOYU@nokia.com>
Message-ID: <CAK=WgbYv0dhBZGo+_sxU+hj-kJEc0E1dk_-Yc2JCDU6SwMeppw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Thu, Aug 18, 2011 at 8:27 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> While we're at it, rename load_iotlb_entry to prefetch_iotlb_entry
>> to better reflect the purpose of that function.
>
> Considering that, originally this function is the counterpart of
> "flush_iotlb_page()" among load_iotlb_/flush_iotlb_*() family and
> OMAP1 doesn't use H/W page table but only uses TLB(only
> prefetch/load_tlb), what about keeping the original function
> "load_iotlb_entry()", and make inline function
> "prefetch_iotlb_entry()" has it?

Sure, np (I have considered doing that, but decided to drop it for now
since there's no other user of load_iotlb_entry currently. Now that
you mention it too, I'll do that).

Thanks,
Ohad.

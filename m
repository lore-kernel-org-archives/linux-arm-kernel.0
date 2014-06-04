From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 4 Jun 2014 14:59:32 +0100
Subject: [PATCH v2] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <20140604133029.GE19587@lvm>
References: <1401286977-59260-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC2MQdxuCWXygQ-072Pr-GBFGcC044AfKWR4kpuBbEmOJQ@mail.gmail.com>
 <20140604133029.GE19587@lvm>
Message-ID: <CAPvkgC0ph4tvBSiYJNzKjmJOZnCSD+5z-Ctdm3gqNKTo2_WREg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2014 14:30, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, Jun 03, 2014 at 02:52:58PM +0100, Steve Capper wrote:

[ ... ]

>>
>> I don't quite follow this clear_p[um]d_entry logic.
>> So this clear_pmd_entry will de-allocate the page containing the ptes
>> (referenced from the pmd entry)?
>
> Yes.
>
>> If so, what happens if not all the ptes in the page need to be unmapped?
>
> Well, then pte_table_empty() will return false (because there are still
> active pte's in the pte table) and we won't call the function.
>
> The idea is that we ref-count each page table page with the number of
> active entries in that page (in addition to the initial reference from
> allocating the table).  So a ref-count of 1 means that there are no
> active entries (xxx_table_empty() returns true), a refcount of 513 means
> there are 512 active entries.
>
> Makes sense?

Thanks Christoffer,
Yes that makes perfect sense.

Cheers,
-- 
Steve

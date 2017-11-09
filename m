From: zhengqiang10@huawei.com (Zhengqiang)
Date: Thu, 9 Nov 2017 20:22:53 +0800
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <5A04489D.2040201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/10/31 23:38, James Morse wrote:
> GHES is doing ioremap_page_range() in both NMI and irq context, neither
> are safe as it may sleep to allocate intermediate levels of page table.
> 
> Replace the NMI/irq GHES_IOREMAP_PAGES to use a fixmap entry each.
> 
> After this nothing uses ghes_ioremap_area or arch_apei_flush_tlb_one(),
> rip them out.
> 
> RFC as I've only build-tested this on x86. For arm64 I've tested it on a
> software model. Any more testing would be welcome. These patches are based
> on rc7.
> 


Tested-by:  Qiang Zheng <zhengqiang10@huawei.com>

Verified on our arm64, it work for me. Thanks.

Qiang

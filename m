From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Tue, 31 Oct 2017 14:46:36 -0400
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <6373c223-5b53-f6a0-6867-a2be8bb9f44c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2017 11:38 AM, James Morse wrote:
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
For the arm64 and APEI patches:
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Verified on arm64. I no longer see the BUGs in the GHES code. Thanks!

Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

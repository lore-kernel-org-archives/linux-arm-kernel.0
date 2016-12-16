From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 16 Dec 2016 09:57:20 +0800
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <20161215153930.GA8111@rric.localdomain>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
 <20161215153930.GA8111@rric.localdomain>
Message-ID: <125f3064-bbec-d923-ad9f-b2d152ee2c2d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 2016/12/15 23:39, Robert Richter wrote:
> I was going to do some measurements but my kernel crashes now with a
> page fault in efi_rtc_probe():
>
> [   21.663393] Unable to handle kernel paging request at virtual address 20251000
> [   21.663396] pgd = ffff000009090000
> [   21.663401] [20251000] *pgd=0000010ffff90003
> [   21.663402] , *pud=0000010ffff90003
> [   21.663404] , *pmd=0000000fdc030003
> [   21.663405] , *pte=00e8832000250707
>
> The sparsemem config requires the whole section to be initialized.
> Your patches do not address this.

This patch set is running properly on D05, both the boot and
LTP MM stress test are ok, seems it's a different configuration
of memory mappings in firmware, just a stupid question, which
part is related to this problem, is it only the Reserved memory?

Thanks
Hanjun

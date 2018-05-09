From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 9 May 2018 15:47:19 +0000
Subject: [PATCH 3/3] x86/mm: disable ioremap free page handling on x86-PAE
In-Reply-To: <20180430175925.2657-4-toshi.kani@hpe.com>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
 <20180430175925.2657-4-toshi.kani@hpe.com>
Message-ID: <1525880775.2693.558.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-04-30 at 11:59 -0600, Toshi Kani wrote:
> ioremap() supports pmd mappings on x86-PAE.  However, kernel's pmd
> tables are not shared among processes on x86-PAE.  Therefore, any
> update to sync'd pmd entries need re-syncing.  Freeing a pte page
> also leads to a vmalloc fault and hits the BUG_ON in vmalloc_sync_one().
> 
> Disable free page handling on x86-PAE.  pud_free_pmd_page() and
> pmd_free_pte_page() simply return 0 if a given pud/pmd entry is present.
> This assures that ioremap() does not update sync'd pmd entries at the
> cost of falling back to pte mappings.
> 
> Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
> Reported-by: Joerg Roedel <joro@8bytes.org>

Hi Joerg,

Does it solve your problem?  Let me know if you have any issue with the
series. 

Thanks,
-Toshi

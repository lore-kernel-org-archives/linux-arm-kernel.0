From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Tue, 21 Jul 2015 12:16:07 +0200
Subject: [PATCH v2 06/20] block/xen-blkfront: Store a page rather a pfn
 in the grant structure
In-Reply-To: <1436474552-31789-7-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-7-git-send-email-julien.grall@citrix.com>
Message-ID: <55AE1BE7.5030102@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 09/07/15 a les 22.42, Julien Grall ha escrit:
> All the usage of the field pfn are done using the same idiom:
> 
> pfn_to_page(grant->pfn)
> 
> This will  return always the same page. Store directly the page in the
> grant to clean up the code.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn? <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

With one style fix.

[...]

>  static struct grant *get_grant(grant_ref_t *gref_head,
> -                               unsigned long pfn,
> +			       struct page *page,

Indentation.

Roger.

From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 21 Jul 2015 12:19:31 +0100
Subject: [Xen-devel] [PATCH v2 06/20] block/xen-blkfront: Store a page
 rather a pfn in the grant structure
In-Reply-To: <55AE1BE7.5030102@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-7-git-send-email-julien.grall@citrix.com>
 <55AE1BE7.5030102@citrix.com>
Message-ID: <55AE2AC3.7070904@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 21/07/15 11:16, Roger Pau Monn? wrote:
> El 09/07/15 a les 22.42, Julien Grall ha escrit:
>> All the usage of the field pfn are done using the same idiom:
>>
>> pfn_to_page(grant->pfn)
>>
>> This will  return always the same page. Store directly the page in the
>> grant to clean up the code.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Roger Pau Monn? <roger.pau@citrix.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
> 
> Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
> 
> With one style fix.
> 
> [...]
> 
>>  static struct grant *get_grant(grant_ref_t *gref_head,
>> -                               unsigned long pfn,
>> +			       struct page *page,
> 
> Indentation.

The indentation for the parameters of this function wasn't correct:

 static struct grant *get_grant(grant_ref_t *gref_head,
-                               unsigned long pfn,
+^I^I^I       struct page *page,
                                struct blkfront_info *info)

So "struct page *page" is correctly indent but not the remaining
parameter ("struct blkfront_info *info"). I will indent it correctly.

Regards,

-- 
Julien Grall

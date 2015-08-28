From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 28 Aug 2015 15:29:19 +0100
Subject: [Xen-devel] [PATCH v3 04/20] xen/grant: Introduce helpers to
 split a page into grant
In-Reply-To: <55D5A337.7090704@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-5-git-send-email-julien.grall@citrix.com>
 <55D5A337.7090704@citrix.com>
Message-ID: <55E0703F.5060003@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 20/08/15 10:51, David Vrabel wrote:
> On 07/08/15 17:46, Julien Grall wrote:
>> Currently, a grant is always based on the Xen page granularity (i.e
>> 4KB). When Linux is using a different page granularity, a single page
>> will be split between multiple grants.
>>
>> The new helpers will be in charge to split the Linux page into grants and
>> call a function given by the caller on each grant.
>>
>> Also provide an helper to count the number of grants within a given
>> contiguous region.
>>
>> Note that the x86/include/asm/xen/page.h is now including
>> xen/interface/grant_table.h rather than xen/grant_table.h. It's
>> necessary because xen/grant_table.h depends on asm/xen/page.h and will
>> break the compilation. Furthermore, only definition in
>> interface/grant_table.h was required.
> 
> Reviewed-by: David Vrabel <david.vrabel@citrix.com>
> But...
> 
>> +/* Helper to get to call fn only on the first "grant chunk" */
>> +static inline void gnttab_one_grant(struct page *page, unsigned int offset,
>> +				    unsigned len, xen_grant_fn_t fn,
>> +				    void *data)
> 
> ...call this gnttab_for_one_grant().

Will rename it on the next version.

Regards,

-- 
Julien Grall

From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 19 May 2015 15:19:07 +0100
Subject: [Xen-devel] [RFC 13/23] xen/xenbus: Use Xen page definition
In-Reply-To: <555B41D1.7010400@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-14-git-send-email-julien.grall@citrix.com>
 <555B41D1.7010400@citrix.com>
Message-ID: <555B465B.9070502@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 19/05/15 14:59, David Vrabel wrote:
> On 14/05/15 18:00, Julien Grall wrote:
>> The xenstore ring is always based on the page granularity of Xen.
> [...]
>> --- a/drivers/xen/xenbus/xenbus_probe.c
>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>> @@ -713,7 +713,7 @@ static int __init xenstored_local_init(void)
>>  
>>  	xen_store_mfn = xen_start_info->store_mfn =
>>  		pfn_to_mfn(virt_to_phys((void *)page) >>
>> -			   PAGE_SHIFT);
>> +			   XEN_PAGE_SHIFT);
> 
> This is page_to_mfn() that you adjusted in the previous patch.

Right, I think there is a couple of other places where page_to_mfn can
be used.

Regards,

-- 
Julien Grall

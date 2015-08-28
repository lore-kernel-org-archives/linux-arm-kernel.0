From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 28 Aug 2015 16:03:14 +0100
Subject: [Xen-devel] [PATCH v3 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <55D5A42E.7070800@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
 <55D5A42E.7070800@citrix.com>
Message-ID: <55E07832.1010802@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 20/08/15 10:55, David Vrabel wrote:
> On 07/08/15 17:46, Julien Grall wrote:
>> The console ring is always based on the page granularity of Xen.
> [...]
>> --- a/drivers/tty/hvc/hvc_xen.c
>> +++ b/drivers/tty/hvc/hvc_xen.c
>> @@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
>>  	if (r < 0 || v == 0)
>>  		goto err;
>>  	gfn = v;
>> -	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
>> +	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, PAGE_SIZE);
> 
> You need XEN_PAGE_SIZE here I think...

Right, I did the mistake while rebase on my s/mfn/gfn/ series. I will
fix it in the next version.

Regards,

-- 
Julien Grall

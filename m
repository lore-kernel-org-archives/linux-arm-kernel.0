From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 19 May 2015 15:18:24 +0100
Subject: [Xen-devel] [RFC 12/23] xen: Extend page_to_mfn to take an offset
 in the page
In-Reply-To: <555B4167.7050506@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-13-git-send-email-julien.grall@citrix.com>
 <555B4167.7050506@citrix.com>
Message-ID: <555B4630.8050304@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 19/05/15 14:57, David Vrabel wrote:
> On 14/05/15 18:00, Julien Grall wrote:
>> With 64KB page granularity support in Linux, a page will be split accross
>> multiple MFN (Xen is using 4KB page granularity). Thoses MFNs may not be
>> contiguous.
>>
>> With the offset in the page, the helper will be able to know which MFN
>> the driver needs to retrieve.
> 
> I think a gnttab_grant_foreign_access_ref()-like helper that takes a
> page would be better.
>
> You will probably want this helper able to return/fill a set of refs for
> 64 KiB pages.

I will see what I can do.

Although, I think this patch is still valid to avoid wrong usage with
64KB page granularity by the caller.

The developer may think that MFN are contiguous which is not always true.

Regards,

-- 
Julien Grall

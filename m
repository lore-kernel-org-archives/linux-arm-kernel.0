From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 18 Nov 2015 11:17:35 +0800
Subject: [PATCH v3 50/62] xen/efi: store EFI system table in efi structure
In-Reply-To: <564B1613.9060204@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-51-git-send-email-shannon.zhao@linaro.org>
 <564B1613.9060204@citrix.com>
Message-ID: <564BEDCF.2050207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/17 19:57, Julien Grall wrote:
> Hi Shannon,
> 
> On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> When preparing EFI tables for Dom0, it needs the information of EFI
>> system table. Here store it in efi structure.
> 
> On ARM64 the EFI stub is completely independent and therefore it's not
> possible to share variable between Xen and the stub.
> 
> If it's working today is only by luck as we zero the BSS after the stub
> jumped to Xen entry point.
> 
Yes, that's right. Sorry, I didn't investigate this deeply while just
getting this patch of Parth version.

I re-think about it. The reason why we need that variable is that when
we create EFI System table for Dom0 it copies the table header from
that. Since it supplies Dom0 a Xen specific UEFI and it could get the
information from other way, this change is not necessary. I'll drop this
at next version.

Thanks,
-- 
Shannon

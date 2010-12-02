From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Thu, 2 Dec 2010 08:50:07 -0600
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
In-Reply-To: <20101202123304.GB10461@n2100.arm.linux.org.uk>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
>> Hi Tony,
>>
>> The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
>> ? Linus Torvalds (1):
>> ? ? ? ? Linux 2.6.37-rc4
>>
>> are available in the git repository at:
>>
>> ? git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
>>
>> Fernando Guzman Lugo (5):
>> ? ? ? OMAP: mailbox: change full flag per mailbox queue instead of global
>> ? ? ? omap: iovmm - no gap checking for fixed address
>> ? ? ? omap: iovmm - add superpages support to fixed da address
>> ? ? ? omap: iovmm - replace __iounmap with omap_iounmap
>
> This change is wrong. ?Nothing should be directly referencing omap_iounmap
> nor for that matter omap_ioremap. ?Both are implementation details of the
> standard ioremap/iounmap APIs.
>
> Use the official APIs rather than the implementation details behind them.

if you see where the function is used, you will see that it is not
calling the function, it is use as a parameter in unmap_vm_area(), if
I used iounmap which is a macro there I will get a compilation error.
It was already discuss with Hiroshi. The function unmap_vm_area can be
re-implemented after with other patch to avoid receiving such that
parameter, but now it is important resolve the memory leak and the
kernel warning. Also the same was being done before, using __iounmap,
so using function directly behind iounmap was not introduce with my
patch. If you have a better solution please let me know and I will
change the patch.

Thanks,
Fernando.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

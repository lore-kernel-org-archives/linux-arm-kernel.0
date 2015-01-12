From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 12 Jan 2015 11:54:15 +0000
Subject: ARM64: hibernation: How to use hibernation/suspend-to-disk on
 ARMv8?
In-Reply-To: <CADcZZT+nQ_0LfurU+z5wLC_OxNhEs6n0kCoLSkfoFCDqyOu04g@mail.gmail.com>
References: <CADcZZT+nQ_0LfurU+z5wLC_OxNhEs6n0kCoLSkfoFCDqyOu04g@mail.gmail.com>
Message-ID: <20150112115415.GB14519@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 03:14:33PM +0000, George Bush wrote:
> Hi all
> 
> I notice we have hibernation.c in arm/kernel, however, I don't find it in arm64.
> Does it mean arm64 do not support hibernation/suspend-to-disk function?

Yes, not at the moment, but we have planned to implement it.

> I tried some path to search the reason, but found nothing, they all say arm64
> has the backward compatibility. So I send this email to the community and
> hope to get the reason.
> Thanks!
> 
> I ported the arm hibernation.c to arm64/kernel(with LP64), but failed in a
> strange way. When I do resume, the arch_restore_image() get a page_fault
> when it calls the copy_page(), like:
> "Unable to handle kernel paging request at virtual address 0xffffffbc055c3fa8"
> I'm sure the copy_page()'s parameters is in the memory area, why and how
> I get the strange address 0xffffffbc055c3fa8?
> 
> vmalloc:         0xffffff8000000000 - 0xffffffbb00000000
> vmemmap:     0xffffffbc01400000 - 0xffffffbc04f88000
> modules:       0xffffffbffc000000   -  0xffffffc000000000
> memory:        0xffffffc000000000 - 0xffffffc0be800000
> 
> 
> Look forward to your reply, thanks!

We need your patch, kernel version, config file, your board/SoC HW details
before even assuming what is happening. Please provide them and I
am happy to help you implement suspend-to-disk on arm64 properly.

Thanks,
Lorenzo

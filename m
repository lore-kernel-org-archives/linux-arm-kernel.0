From: hejianet@gmail.com (Jia He)
Date: Thu, 5 Apr 2018 20:29:30 +0800
Subject: [PATCH v7 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
In-Reply-To: <20180405112357.GA2647@bombadil.infradead.org>
References: <1522915478-5044-1-git-send-email-hejianet@gmail.com>
 <1522915478-5044-2-git-send-email-hejianet@gmail.com>
 <20180405112357.GA2647@bombadil.infradead.org>
Message-ID: <fda3d3d4-b1da-6020-4257-1c8819800930@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Matthew


On 4/5/2018 7:23 PM, Matthew Wilcox Wrote:
> On Thu, Apr 05, 2018 at 01:04:34AM -0700, Jia He wrote:
>>   create mode 100644 include/linux/arm96_common.h
> 'arm96_common'?!  No.  Just no.
>
> The right way to share common code is to create a header file (or use
> an existing one), either in asm-generic or linux, with a #ifdef CONFIG_foo
> block and then 'select foo' in the arm Kconfig files.  That allows this
> common code to be shared, maybe with powerpc or x86 or ... in the future.
>
ok
How about include/asm-generic/early_pfn.h ?
And could I use CONFIG_HAVE_ARCH_PFN_VALID and CONFIG_HAVE_MEMBLOCKin 
this case?
Currently, arm/arm64 have memblock enable by default. When other arches 
implement
their HAVE_MEMBLOCK and HAVE_ARCH_PFN_VALID, they can include this file?

-- 
Cheers,
Jia

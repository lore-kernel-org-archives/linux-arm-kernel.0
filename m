From: steve.capper@arm.com (Steve Capper)
Date: Mon, 16 Jan 2017 12:57:24 +0000
Subject: [Question] A question about arm64 pte
In-Reply-To: <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
References: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
 <20170116115606.GA6832@e104818-lin.cambridge.arm.com>
 <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
Message-ID: <20170116125724.GA16265@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 08:39:56PM +0800, Yisheng Xie wrote:
> hi Catalin,
> Thank you so much for you reply.
> 
> On 2017/1/16 19:56, Catalin Marinas wrote:
> > On Mon, Jan 16, 2017 at 06:08:47PM +0800, Yisheng Xie wrote:
> >> I have question about arm64 pte.
> > 
> > I assume the context is ARMv8.0 (without hardware DBM support).
> 
> Yes.
> > 
> >> For arm64, PTE_WRITE?== PTE_DBM? is to mark whether the page is writable,
> >> and PTE_DIRTY is to mark whether the page is dirty.
> >> However, PTE_RDONLY is only cleared when both PTE_WRITE and PTE_DIRTY are set.
> > 
> > That's what set_pte_at() does.
> > 
> 
> So if we mmap a memory region use /dev/mem like:
>    fildes = open("/dev/mem", O_RDWR | O_CREAT, 0777);
>    addr = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, fildes, offset);
> 
> The PTE_RDONLY will be set? Right ?
> However?when use memset to write the region it still works well, and the bit PTE_RDONLY is also cleared.
> Is there anywhere clear the PTE_RDONLY before write that page ?
> 

Hi Yisheng,
Out of interest, why is /dev/mem being accessed directly from userspace?

The case above will have subtley different logic (mmap_mem will affect
how things are actually mapped); which I'm trying to understand...

Cheers,
-- 
Steve

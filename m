From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2016 17:43:49 +0000
Subject: [PATCH v6sub1 00/11] arm64: split linear and kernel mappings
In-Reply-To: <CAKv+Gu9L4DZjnBPbTUY8bXBLZexCAJpqhV=YBm5EYaq868_mSg@mail.gmail.com>
References: <CAKv+Gu_UqoYB5QAWOU9_iZDoRO=rqHu8o87JboSAqNqOhoOCXw@mail.gmail.com>
 <CAKv+Gu_25mz37gdgVx5Yz7DJ+QbOMNa4rYBymFL1nL7nGOzBVQ@mail.gmail.com>
 <CAKv+Gu8aKDtev2LdGMy9a485Z8S7TYgsbXky6wR6e3F+j2nkUQ@mail.gmail.com>
 <20160219142551.GA12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_44=2NMuon694T_YW6QUU-ixC+q_7WxbMtBuN3dRNP2Q@mail.gmail.com>
 <CAKv+Gu9WTVrYmc7GwxDeHppSHoRmSS4nK5iG3HZVMOPcPP1MOw@mail.gmail.com>
 <20160219143701.GB12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-3y9LoxM9swbwZuXXxuMppnWzd=PmyALa+P0NhvR7mtw@mail.gmail.com>
 <20160219173411.GE12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9L4DZjnBPbTUY8bXBLZexCAJpqhV=YBm5EYaq868_mSg@mail.gmail.com>
Message-ID: <20160219174349.GF12864@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 06:38:19PM +0100, Ard Biesheuvel wrote:
> > I noticed that we still have MODULES_VADDR around and used in couple of
> > places (printing the kernel memory layout during init, debugfs
> > kernel_page_tables and KASAN). Shouldn't we use module_alloc_base
> > instead?
> 
> For KASAN, I updated the patches so that the modules are always
> allocated in the original module region, to prevent issues with the
> zero shadow that backs the vmalloc region.

Ah, I forgot about this.

> For the other purposes, it is really a matter of taste. The reserved
> region still exists, KASLR or not, so if you omit it, you will have a
> hole in the memory map. For the page table dumper, i did not add a
> special section for the kernel either.
> 
> I'm happy to propose a patch that changes that, once we (you) decide
> what you want to see.

Leave it as it is for now.

-- 
Catalin

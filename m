From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 22 Feb 2016 14:19:14 -0800
Subject: [PATCH] nvdimm: use 'u64' for pfn flags
In-Reply-To: <1456178322-1728962-1-git-send-email-arnd@arndb.de>
References: <1456178322-1728962-1-git-send-email-arnd@arndb.de>
Message-ID: <CAPcyv4j-ByA7u0jnnLHeiEYNZU78-twRzQUoeo2BkmtODCAGHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 1:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A recent bugfix changed pfn_t to always be 64-bit wide, but did not
> change the code in pmem.c, which is now broken on 32-bit architectures
> as reported by gcc:
>
> In file included from ../drivers/nvdimm/pmem.c:28:0:
> drivers/nvdimm/pmem.c: In function 'pmem_alloc':
> include/linux/pfn_t.h:15:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
>
> This changes the intermediate pfn_flags in struct pmem_device to
> be 64 bit wide as well, so they can store the flags correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: db78c22230d0 ("mm: fix pfn_t vs highmem")

Thanks Arnd, I'll roll this up.

From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 18:25:24 +0000
Subject: [PATCHv3 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <1479431816-5028-7-git-send-email-labbott@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-7-git-send-email-labbott@redhat.com>
Message-ID: <20161118182523.GG1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:16:56PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 54bb209..0d37c19 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -5,6 +5,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
>  obj-$(CONFIG_NUMA)		+= numa.o
> +obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o

We'll also need:

KASAN_SANITIZE_physaddr.o	:= n

... or code prior to KASAN init will cause the kernel to die if
__virt_to_phys() or __phys_addr_symbol() are called.

>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>  KASAN_SANITIZE_kasan_init.o	:= n

Thanks,
Mark,

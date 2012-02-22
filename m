From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 21 Feb 2012 16:18:02 -0800
Subject: [PATCHv22 14/16] X86: integrate CMA with DMA-mapping subsystem
In-Reply-To: <1329507036-24362-15-git-send-email-m.szyprowski@samsung.com>
References: <1329507036-24362-1-git-send-email-m.szyprowski@samsung.com>
 <1329507036-24362-15-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120221161802.f6a28085.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Feb 2012 20:30:34 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch adds support for CMA to dma-mapping subsystem for x86
> architecture that uses common pci-dma/pci-nommu implementation. This
> allows to test CMA on KVM/QEMU and a lot of common x86 boxes.
> 
> ...
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -31,6 +31,7 @@ config X86
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARCH_WANT_FRAME_POINTERS
>  	select HAVE_DMA_ATTRS
> +	select HAVE_DMA_CONTIGUOUS if !SWIOTLB
>  	select HAVE_KRETPROBES
>  	select HAVE_OPTPROBES
>  	select HAVE_FTRACE_MCOUNT_RECORD

I don't think it's compilable at all for x86_64, because that platform
selects SWIOTLB.

After a while I got it to compile for i386.  arm didn't go so well,
partly because arm allmodconfig is presently horked (something to do
with Kconfig not setting PHYS_OFFSET) and partly because arm defconfig
doesn't permit CMA to be set.  Got bored, gave up.

The patchset collides pretty seriously with pending dma api changes and
pending arm changes in linux-next, so I didn't apply anything.  This
will all need to be looked at, please.

I'll make do with reading the patches for now ;)

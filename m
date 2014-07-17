From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 Jul 2014 14:31:48 +0200
Subject: [PATCH 0/4] mips: Add cma support to mips
In-Reply-To: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <53C7C234.4030903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-07-16 17:51, Zubair Lutfullah Kakakhel wrote:
> Here we have 4 patches that add cma support to mips.
>
> Patch 1 adds dma-contiguous.h to asm-generic
> Patch 2 and 3 make arm64 and x86 use dma-contiguous from asm-generic
> Patch 4 adds cma to mips.
>
> I'd like to request ralf to take these set of 4 patches via his tree.
>
> acks from asm-generic, arm64 and x86 welcome.
>
> patches based on linux-next b997a07604562f1a54cc531fe1cf7447f0ed6078

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Zubair Lutfullah Kakakhel (4):
>    asm-generic: Add dma-contiguous.h
>    arm64: use generic dma-contiguous.h
>    x86: use generic dma-contiguous.h
>    mips: dma: Add cma support
>
>   arch/arm64/include/asm/Kbuild           |  1 +
>   arch/arm64/include/asm/dma-contiguous.h | 28 -------------------------
>   arch/mips/Kconfig                       |  1 +
>   arch/mips/include/asm/Kbuild            |  1 +
>   arch/mips/kernel/setup.c                |  9 ++++++++
>   arch/mips/mm/dma-default.c              | 37 ++++++++++++++++++++++-----------
>   arch/x86/include/asm/Kbuild             |  1 +
>   arch/x86/include/asm/dma-contiguous.h   | 12 -----------
>   include/asm-generic/dma-contiguous.h    |  9 ++++++++
>   9 files changed, 47 insertions(+), 52 deletions(-)
>   delete mode 100644 arch/arm64/include/asm/dma-contiguous.h
>   delete mode 100644 arch/x86/include/asm/dma-contiguous.h
>   create mode 100644 include/asm-generic/dma-contiguous.h

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

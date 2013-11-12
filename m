From: monstr@monstr.eu (Michal Simek)
Date: Tue, 12 Nov 2013 16:39:40 +0100
Subject: [PATCH 00/11] Consolidate asm/fixmap.h files
In-Reply-To: <1384262545-20875-1-git-send-email-msalter@redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
Message-ID: <52824BBC.9020401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 02:22 PM, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.
> 
> This has been compiled on x86, arm, powerpc, and sh, but tested
> on x86 only.
> 
> Mark Salter (11):
>   Add generic fixmap.h
>   x86: use generic fixmap.h
>   arm: use generic fixmap.h
>   hexagon: use generic fixmap.h
>   metag: use generic fixmap.h
>   microblaze: use generic fixmap.h
>   mips: use generic fixmap.h
>   powerpc: use generic fixmap.h
>   sh: use generic fixmap.h
>   tile: use generic fixmap.h
>   um: use generic fixmap.h
> 
>  arch/arm/include/asm/fixmap.h        |  25 ++------
>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>  arch/metag/include/asm/fixmap.h      |  32 +----------
>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>  arch/mips/include/asm/fixmap.h       |  33 +----------
>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>  arch/sh/include/asm/fixmap.h         |  39 +------------
>  arch/tile/include/asm/fixmap.h       |  33 +----------
>  arch/um/include/asm/fixmap.h         |  40 +------------
>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
>  11 files changed, 125 insertions(+), 371 deletions(-)
>  create mode 100644 include/asm-generic/fixmap.h

Any repo/branch with all these patches will be helpful.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/026a7f78/attachment.sig>

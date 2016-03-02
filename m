From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2016 02:15:50 +0000
Subject: [PATCH 2/2] numa, mm, cleanup: remove redundant NODE_DATA macro
 from asm header files.
In-Reply-To: <1456358528-24213-3-git-send-email-ddaney.cavm@gmail.com>
References: <1456358528-24213-1-git-send-email-ddaney.cavm@gmail.com>
 <1456358528-24213-3-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160302021550.GI14022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 04:02:08PM -0800, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> NODE_DATA is defined across multiple asm header files.
> Moving generic definition to asm-generic/mmzone.h to
> remove redundant definitions.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/include/asm/mmzone.h   |  4 +---
>  arch/m32r/include/asm/mmzone.h    |  4 +---
>  arch/metag/include/asm/mmzone.h   |  4 +---
>  arch/powerpc/include/asm/mmzone.h |  8 ++------
>  arch/s390/include/asm/mmzone.h    |  6 +-----
>  arch/sh/include/asm/mmzone.h      |  4 +---
>  arch/sparc/include/asm/mmzone.h   |  6 ++----
>  arch/x86/include/asm/mmzone.h     |  3 +--
>  arch/x86/include/asm/mmzone_32.h  |  5 -----
>  arch/x86/include/asm/mmzone_64.h  | 17 -----------------
>  include/asm-generic/mmzone.h      | 24 ++++++++++++++++++++++++
>  11 files changed, 34 insertions(+), 51 deletions(-)
>  delete mode 100644 arch/x86/include/asm/mmzone_64.h
>  create mode 100644 include/asm-generic/mmzone.h
> 
> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> index a0de9e6..611a1cf 100644
> --- a/arch/arm64/include/asm/mmzone.h
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -4,9 +4,7 @@
>  #ifdef CONFIG_NUMA
>  
>  #include <asm/numa.h>
> -
> -extern struct pglist_data *node_data[];
> -#define NODE_DATA(nid)		(node_data[(nid)])
> +#include  <asm-generic/mmzone.h>
>  
>  #endif /* CONFIG_NUMA */
>  #endif /* __ASM_MMZONE_H */

Actually, we can remove the header file entirely and use a generic-y
line in Kbuild instead.

Will

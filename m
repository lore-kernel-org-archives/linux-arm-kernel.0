From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 14:07:48 +0000
Subject: [PATCHv2 03/14] arm64: Use set_memory.h header
In-Reply-To: <1488413706-9739-4-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-4-git-send-email-labbott@redhat.com>
Message-ID: <20170302140747.GK19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:14:55PM -0800, Laura Abbott wrote:
> 
> The set_memory_* functions have moved to set_memory.h. Use that header
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm64/mm/pageattr.c      | 1 +
>  arch/arm64/net/bpf_jit_comp.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 8def55e..12ab86d 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -18,6 +18,7 @@
>  
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
> +#include <asm/set_memory.h>

Nit: alphabetical order, please.

>  
>  struct page_change_data {
>  	pgprot_t set_mask;
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a785554..84e4a91 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -26,6 +26,7 @@
>  
>  #include <asm/byteorder.h>
>  #include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  #include <asm/debug-monitors.h>

Nit: likewise.

Otherwise, this looks fine to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  #include "bpf_jit.h"
> -- 
> 2.7.4
> 

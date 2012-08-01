From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 1 Aug 2012 10:48:18 -0400
Subject: [PATCH 18/24] xen/arm: compile blkfront and blkback
In-Reply-To: <1343316846-25860-18-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-18-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120801144818.GO7227@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:34:00PM +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  drivers/block/xen-blkback/blkback.c  |    1 +
>  include/xen/interface/io/protocols.h |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 73f196c..63dd5b9 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -42,6 +42,7 @@
>  
>  #include <xen/events.h>
>  #include <xen/page.h>
> +#include <xen/xen.h>
>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
>  #include "common.h"
> diff --git a/include/xen/interface/io/protocols.h b/include/xen/interface/io/protocols.h
> index 01fc8ae..0eafaf2 100644
> --- a/include/xen/interface/io/protocols.h
> +++ b/include/xen/interface/io/protocols.h
> @@ -5,6 +5,7 @@
>  #define XEN_IO_PROTO_ABI_X86_64     "x86_64-abi"
>  #define XEN_IO_PROTO_ABI_IA64       "ia64-abi"
>  #define XEN_IO_PROTO_ABI_POWERPC64  "powerpc64-abi"
> +#define XEN_IO_PROTO_ABI_ARM        "arm-abi"

So one that has all of the 32/64 issues worked out? Nice.

>  
>  #if defined(__i386__)
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_32
> @@ -14,6 +15,8 @@
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_IA64
>  #elif defined(__powerpc64__)
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_POWERPC64
> +#elif defined(__arm__)
> +# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_ARM
>  #else
>  # error arch fixup needed here
>  #endif
> -- 
> 1.7.2.5

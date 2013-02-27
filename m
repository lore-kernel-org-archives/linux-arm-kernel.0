From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Feb 2013 11:05:24 -0600
Subject: [PATCH 1/3] libfdt: add fdt type definitions in libfdt_env.h
In-Reply-To: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
References: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
Message-ID: <512E3CD4.6000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:36 PM, Kim Phillips wrote:
> in preparation for the forthcoming dtc update which adds fdt specific
> types: fdt{16,32,64}_t.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/arm/boot/compressed/libfdt_env.h | 4 ++++
>  include/linux/libfdt_env.h            | 6 ++++++

We should kill off arch/arm/boot/compressed/libfdt_env.h and use
include/linux/libfdt_env.h instead. The only reason I see why we have
both is the ARM version was introduced before include/linux/libfdt_env.h
existed.

Rob

>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
> index 1f4e718..17ae0f3 100644
> --- a/arch/arm/boot/compressed/libfdt_env.h
> +++ b/arch/arm/boot/compressed/libfdt_env.h
> @@ -5,6 +5,10 @@
>  #include <linux/string.h>
>  #include <asm/byteorder.h>
>  
> +typedef __be16 fdt16_t;
> +typedef __be32 fdt32_t;
> +typedef __be64 fdt64_t;
> +
>  #define fdt16_to_cpu(x)		be16_to_cpu(x)
>  #define cpu_to_fdt16(x)		cpu_to_be16(x)
>  #define fdt32_to_cpu(x)		be32_to_cpu(x)
> diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> index 01508c7..da98097 100644
> --- a/include/linux/libfdt_env.h
> +++ b/include/linux/libfdt_env.h
> @@ -5,6 +5,12 @@
>  
>  #include <asm/byteorder.h>
>  
> +typedef __be16 fdt16_t;
> +typedef __be32 fdt32_t;
> +typedef __be64 fdt64_t;
> +
> +#define fdt16_to_cpu(x) be16_to_cpu(x)
> +#define cpu_to_fdt16(x) cpu_to_be16(x)
>  #define fdt32_to_cpu(x) be32_to_cpu(x)
>  #define cpu_to_fdt32(x) cpu_to_be32(x)
>  #define fdt64_to_cpu(x) be64_to_cpu(x)
> 

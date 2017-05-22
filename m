From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 May 2017 07:53:04 -0700
Subject: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20170519175708.6070-3-d-gerlach@ti.com>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com>
Message-ID: <20170522145304.GO10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [170519 11:00]:
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 608008229c7d..d728b5660e36 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -28,6 +28,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
> +#include <linux/ti-emif-sram.h>
>  
>  /*
>   * Make sure that the compiler and target are compatible.
> @@ -183,5 +184,10 @@ int main(void)
>  #ifdef CONFIG_VDSO
>    DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
>  #endif
> +#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
> +  BLANK();
> +  ti_emif_offsets();
> +#endif
> +
>    return 0; 
>  }

Above still needs to be commented by Russell.

As far as I'm concerned:

Acked-by: Tony Lindgren <tony@atomide.com>

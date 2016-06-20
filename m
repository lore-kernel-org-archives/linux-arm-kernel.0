From: james.morse@arm.com (James Morse)
Date: Mon, 20 Jun 2016 17:06:22 +0100
Subject: [PATCH v19 05/13] arm64/kexec: Add pr_debug output
In-Reply-To: <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
References: <cover.1466120418.git.geoff@infradead.org>
 <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
Message-ID: <5768147E.1050900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 17/06/16 00:48, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to
> kexec add a new routine kexec_image_info() and several inline pr_debug
> statements.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index a6dcb9c..7372e58 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/kexec.h>
>  #include <linux/smp.h>
> +#include <linux/uaccess.h>

Now that the get_user(maybe_dtb_addr,.. has gone, I don't think we need this header.

>  
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

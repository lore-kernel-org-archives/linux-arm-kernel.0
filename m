From: bp@suse.de (Borislav Petkov)
Date: Fri, 1 Sep 2017 13:16:48 +0200
Subject: [RFC PATCH v1 1/3] arm64/ras: support sea error recovery
In-Reply-To: <1504261921-39308-2-git-send-email-xiexiuqi@huawei.com>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
 <1504261921-39308-2-git-send-email-xiexiuqi@huawei.com>
Message-ID: <20170901111648.jrb3picf5m4clu3s@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 06:31:59PM +0800, Xie XiuQi wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..fa9400d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -52,6 +52,7 @@
>  #include <acpi/ghes.h>
>  #include <acpi/apei.h>
>  #include <asm/tlbflush.h>
> +#include <asm/ras.h>
>  #include <ras/ras_event.h>
>  
>  #include "apei-internal.h"
> @@ -520,6 +521,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  
> +			arm_proc_error_check(ghes, err);
>  			log_arm_hw_error(err);

Wrap those two in a single arm_process_error() which does everything
needed on ARM.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 

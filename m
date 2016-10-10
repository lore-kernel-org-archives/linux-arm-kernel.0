From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Mon, 10 Oct 2016 21:25:55 +0530
Subject: [PATCH] kernel: irq: fix build failure
In-Reply-To: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <57FBBA0B.9070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 October 2016 11:06 PM, Sudip Mukherjee wrote:
> The allmodconfig build of powerpc is failing with the error:
> ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
>
> export the symbol to fix the failure.

Hi Thomas,
powerpc and arm allmodconfig builds still fails with the same error.
Build logs of next-20161010 are at:
arm at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321467
powerpc at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321473

Regards
Sudip

>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/165418652
>
>   kernel/irq/manage.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 0c5f1a5..5072814 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -721,6 +721,7 @@ int irq_set_parent(int irq, int parent_irq)
>   	irq_put_desc_unlock(desc, flags);
>   	return 0;
>   }
> +EXPORT_SYMBOL(irq_set_parent);
>   #endif
>
>   /*
>

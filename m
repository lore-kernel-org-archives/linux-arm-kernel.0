From: kristoffer.ericson@gmail.com (Kristoffer Eriksson)
Date: Wed, 27 Jun 2012 15:41:41 +0200
Subject: [PATCH] ARM: sa1100: fix jornada720 build failure on missing IOMEM
In-Reply-To: <1340752409-11413-1-git-send-email-paul.gortmaker@windriver.com>
References: <1340752409-11413-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4FEB0D95.5070704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>


Paul Gortmaker skrev 2012-06-27 01:13:
> Introduced by commit 6686732c8b8974fafbdd7886de0fcf77cf34ec07 [linux-next]
>
>      "ARM: sa11x0/pxa: convert OS timer registers to IOMEM"
>
> which causes:
>
> arch/arm/mach-sa1100/jornada720_ssp.c:63:2: error: implicit declaration of function 'IOMEM'
>
> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>
> ---
>
> Feel free to squash into original if rebasing.
> Fixes http://kisskb.ellerman.id.au/kisskb/buildresult/6592200/
>
>   arch/arm/mach-sa1100/jornada720_ssp.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
> index b412fc0..ee13507 100644
> --- a/arch/arm/mach-sa1100/jornada720_ssp.c
> +++ b/arch/arm/mach-sa1100/jornada720_ssp.c
> @@ -14,6 +14,7 @@
>   #include<linux/delay.h>
>   #include<linux/errno.h>
>   #include<linux/init.h>
> +#include<linux/io.h>
>   #include<linux/kernel.h>
>   #include<linux/module.h>
>   #include<linux/platform_device.h>

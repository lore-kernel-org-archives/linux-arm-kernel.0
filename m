From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 28 Jan 2016 18:37:19 +0300
Subject: [PATCH 1/2] ARM: shmobile: Move shmobile_scu_base from .text to
 .data
In-Reply-To: <1453993462-12210-2-git-send-email-geert+renesas@glider.be>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
 <1453993462-12210-2-git-send-email-geert+renesas@glider.be>
Message-ID: <56AA35AF.8080601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/28/2016 06:04 PM, Geert Uytterhoeven wrote:

> shmobile_scu_base is being written to, so it doesn't belong in the .text
> section. Fix this by moving it from asm .text to C .data, as it's no
> longer used from asm code since commit 4f6da36f7edd5790 ("ARM: shmobile:
> Remove old SCU boot code").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

> diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
> index 64663110ab6ca0e1..f2198c9c74359736 100644
> --- a/arch/arm/mach-shmobile/platsmp-scu.c
> +++ b/arch/arm/mach-shmobile/platsmp-scu.c
> @@ -17,6 +17,9 @@
>   #include <asm/smp_scu.h>
>   #include "common.h"
>
> +

    Why add 2nd empty line?

> +void __iomem *shmobile_scu_base;
> +
>   static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
>   					  unsigned long action, void *hcpu)
>   {

MBR, Sergei

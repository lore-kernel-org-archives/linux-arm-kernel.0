From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:45:26 +0200
Subject: [GIT PULL] late pxa fixes for v4.1
In-Reply-To: <87siapr9hd.fsf@belgarion.home>
References: <87siapr9hd.fsf@belgarion.home>
Message-ID: <2813839.6H6Qpy74oJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 21:55:42 Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> I have a late trivial patch for the v4.1 cycle. Unlike regular pull request,
> given the very straightforward nature of this patch, could I ask you to
> cherry-pick it directly from this mail ?
> 
> If that doesn't work for you, I'll provide a proper pull request.
> 

Picking up fixes from mail works fine, I've applied it now and plan
to send it out for -rc5.

Just one request:

> --
> Robert
>
> From 87a3253dd948da65d53ebd83e9569510a2c7b192 Mon Sep 17 00:00:00 2001
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Date: Wed, 13 May 2015 14:32:39 +0300
> Subject: [PATCH] ARM: pxa: pxa_cplds: signedness bug in probe

When you have a patch and some other text in the same email, do it
in one of two ways, but not like you did here (as I need to fix that
up manually):

a) put your comments underneath the '---' (three dashes) line at the
   end of the changelog, and send the patch with the correct subject
   line.

b) Put your comments first (as you did here), but then have a line
   with '8<-----', followed by 'Subject: [PATCH] ARM: pxa: ...'

Either of those two will let me use 'git am' to apply the patch.

	Arnd
 
> "base_irq" needs to be signed for the error handling to work.  Also we
> can remove the initialization because we re-assign it later.
> 
> Fixes: aa8d6b73ea33 ('ARM: pxa: pxa_cplds: add lubbock and mainstone IO')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/pxa_cplds_irqs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
> index f1aeb54..2385052 100644
> --- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
> +++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
> @@ -107,7 +107,7 @@ static int cplds_probe(struct platform_device *pdev)
>         struct resource *res;
>         struct cplds *fpga;
>         int ret;
> -       unsigned int base_irq = 0;
> +       int base_irq;
>         unsigned long irqflags = 0;
>  
>         fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

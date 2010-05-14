From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 14 May 2010 14:17:10 +0400
Subject: [PATCH 03/15] omap: mailbox: 2420 should be detected at run-time
In-Reply-To: <1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
	<1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
Message-ID: <4BED2326.4090302@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 252e53b..6d17da8 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -431,7 +431,8 @@ err_dsp:
>  static int __devexit omap2_mbox_remove(struct platform_device *pdev)
>  {
>  #if defined(CONFIG_ARCH_OMAP2420)
> -	omap_mbox_unregister(&mbox_iva_info);
> +	if (cpu_is_omap2420())
> +		omap_mbox_unregister(&mbox_iva_info);
>  #endif

    Shouldn't #ifdef be remove then?

WBR, Sergei

From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 18 Feb 2012 20:00:23 +0400
Subject: [PATCH] ARM: plat-mxc: audmux-v1: Remove unneeded ifdef's
In-Reply-To: <1329437651-8341-1-git-send-email-festevam@gmail.com>
References: <1329437651-8341-1-git-send-email-festevam@gmail.com>
Message-ID: <4F3FCB17.1040706@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-02-2012 4:14, Fabio Estevam wrote:

> As we are able to build a single kernel that can run on mx21 and mx25,
> there is no need for the ifdef's anymore inside audmux-v1.c.

> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
> ---
>   arch/arm/plat-mxc/audmux-v1.c |    5 +----
>   1 files changed, 1 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
> index 1180bef..14a3c04 100644
> --- a/arch/arm/plat-mxc/audmux-v1.c
> +++ b/arch/arm/plat-mxc/audmux-v1.c
> @@ -46,16 +46,13 @@ EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
>
>   static int mxc_audmux_v1_init(void)
>   {
> -#ifdef CONFIG_MACH_MX21
>   	if (cpu_is_mx21())
>   		audmux_base = MX21_IO_ADDRESS(MX21_AUDMUX_BASE_ADDR);
>   	else
> -#endif
> -#ifdef CONFIG_MACH_MX27
> +
>   	if (cpu_is_mx27())

    This should become:

	else if (cpu_is_mx27())

WBR, Sergei

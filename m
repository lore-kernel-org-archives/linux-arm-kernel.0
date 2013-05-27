From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 May 2013 18:04:37 +0400
Subject: [PATCH] ARM: shmobile: sh7372 pinmux platform device cleanup
In-Reply-To: <1369648782-8024-2-git-send-email-horms+renesas@verge.net.au>
References: <1369648782-8024-1-git-send-email-horms+renesas@verge.net.au>
 <1369648782-8024-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51A367F5.5040500@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-05-2013 13:59, Simon Horman wrote:

> From: Magnus Damm <damm@opensource.se>

> Use DEFINE_RES_MEM() and platform_device_register_simple()
> to save a couple of lines of code.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/setup-sh7372.c |   24 +++++-------------------
>   1 file changed, 5 insertions(+), 19 deletions(-)

> diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
> index 5502d62..c70a3cc 100644
> --- a/arch/arm/mach-shmobile/setup-sh7372.c
> +++ b/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -62,29 +62,15 @@ void __init sh7372_map_io(void)
[...]
> +static const struct resource pfc_resources[] = {

    This should have been annotated with __initdata... too late now, 
need another patch.

> +	DEFINE_RES_MEM(0xe6050000, 0x8000),
> +	DEFINE_RES_MEM(0xe605800c, 0x001c),
>   };
>
>   void __init sh7372_pinmux_init(void)
>   {
> -	platform_device_register(&sh7372_pfc_device);
> +	platform_device_register_simple("pfc-sh7372", -1, pfc_resources,
> +					ARRAY_SIZE(pfc_resources));
>   }

WBR, Sergei

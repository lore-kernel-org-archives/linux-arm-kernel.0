From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 May 2013 18:13:22 +0400
Subject: [PATCH 1/8] ARM: shmobile: sh73a0 pinmux platform device cleanup
In-Reply-To: <1369645252-3847-2-git-send-email-horms+renesas@verge.net.au>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
 <1369645252-3847-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51A36A02.9050200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-05-2013 13:00, Simon Horman wrote:

> From: Magnus Damm <damm@opensource.se>

> Use DEFINE_RES_MEM() and platform_device_register_simple()
> to save a couple of lines of code.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/setup-sh73a0.c |   25 ++++++-------------------
>   1 file changed, 6 insertions(+), 19 deletions(-)

> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index fdf3894..f8f4261 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
[...]
> +/* PFC */
> +static const struct resource pfc_resources[] = {

    Should have been annotated as __initdata... too late, need another 
patch.

> +	DEFINE_RES_MEM(0xe6050000, 0x8000),
> +	DEFINE_RES_MEM(0xe605801c, 0x000c),
>   };
>
>   void __init sh73a0_pinmux_init(void)
>   {
> -	platform_device_register(&sh73a0_pfc_device);
> +	platform_device_register_simple("pfc-sh73a0", -1, pfc_resources,
> +					ARRAY_SIZE(pfc_resources));
>   }

WBR, Sergei

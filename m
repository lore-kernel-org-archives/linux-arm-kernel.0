From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Apr 2013 16:27:06 +0400
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <1366599990-31751-1-git-send-email-horms+renesas@verge.net.au>
References: <1366599990-31751-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51752C9A.2040508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-04-2013 7:06, Simon Horman wrote:

> The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> support them.

> Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/board-lager.c | 37 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

> Tested on lager board.
> Based on the tag renesas-next-20130419 of my renesas tree.

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 6114edd..a8aa04f 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> @@ -46,6 +82,7 @@ static void __init lager_add_standard_devices(void)
>   	r8a7790_pinmux_init();
>
>   	r8a7790_add_standard_devices();
> +	platform_add_devices(lager_devices, ARRAY_SIZE(lager_devices));

    I thought we shouldn't use platform_add_devices() anymore, being close 
relative to platform_device_register()?

WBR, Sergei

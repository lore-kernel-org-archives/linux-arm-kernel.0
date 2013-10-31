From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 31 Oct 2013 17:10:03 +0900
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <201310310219.58963.sergei.shtylyov@cogentembedded.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
 <201310310219.58963.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoTNJAnqavonOwtqe5_HDdPwK1-JAixNuz5z7ttQw-T64Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Oct 31, 2013 at 8:19 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Register Ether platform device and pin data on  the  Koelsch board.
> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c

> @@ -70,11 +87,29 @@ static const struct gpio_keys_platform_d
>         .nbuttons       = ARRAY_SIZE(gpio_buttons),
>  };
>
> +static const struct pinctrl_map koelsch_pinctrl_map[] = {
> +       /* Ether */
> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
> +                                 "eth_link", "eth"),
> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
> +                                 "eth_mdio", "eth"),
> +       PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
> +                                 "eth_rmii", "eth"),
> +};

Once again we seem to be using r8a7790 when the actual SoC is r8a7791.
If you're going to go down the route of using the SoC name then please
use the correct one at least.

Cheers,

/ magnus

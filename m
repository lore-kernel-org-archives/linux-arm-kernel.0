From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 16:05:33 +0900
Subject: [PATCH v2 4/4] ARM: shmobile: BOCK-W reference: add Ether PFC
 settings
In-Reply-To: <201309070431.35908.sergei.shtylyov@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
 <201309070431.35908.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoRKFoS9tehteDGaTUYJ8fSBqAYJJDiLxZmoNB9W0N+Mpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 7, 2013 at 9:31 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the Ether pin group to bockw_pinctrl_map[].
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/board-bockw-reference.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> Index: renesas/arch/arm/mach-shmobile/board-bockw-reference.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-bockw-reference.c
> +++ renesas/arch/arm/mach-shmobile/board-bockw-reference.c
> @@ -29,6 +29,9 @@
>   */
>
>  static const struct pinctrl_map bockw_pinctrl_map[] = {
> +       /* Ether */
> +       PIN_MAP_MUX_GROUP_DEFAULT("fde00000.ethernet", "pfc-r8a7778",
> +                                 "ether_rmii", "ether"),
>         /* SCIF0 */
>         PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
>                                   "scif0_data_a", "scif0"),

Hi Sergei,

Thanks for your patches. In general I think your series looks fine. I
have a single comment, and that's about the pinctrl-related hunk
above. I can see that this patch is for DT reference for Bock-W, so I
expect the code to be in DT. Do you have any plans to use DT to
describe the pinmux bits? Perhaps you have some incremental patch
planned?

Cheers,

/ magnus

From: julian.calaby@gmail.com (Julian Calaby)
Date: Thu, 22 Oct 2015 11:15:39 +1100
Subject: [linux-sunxi] [PATCH 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <1445444007-4260-3-git-send-email-jenskuske@gmail.com>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
 <1445444007-4260-3-git-send-email-jenskuske@gmail.com>
Message-ID: <CAGRGNgWyNEOMVxeDFTAp_wJoaXL471spFjBTn+2s7YuKeJf71g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Thu, Oct 22, 2015 at 3:13 AM, Jens Kuske <jenskuske@gmail.com> wrote:
> The H3 clock control unit is similar to the those of other sun8i family
> members like the A23.
>
> It adds a new bus gates clock similar to the simple gates, but with a
> different parent clock for each single gate.
> Some of the gates use the new AHB2 clock as parent, whose clock source
> is muxable between AHB1 and PLL6/2. The documentation isn't totally clear
> about which devices belong to AHB2 now, especially USB EHIC/OHIC, so it
> is mostly based on Allwinner kernel source code.
>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-bus-gates.c                 | 105 ++++++++++++++++++++++
>  drivers/clk/sunxi/clk-sunxi.c                     |  12 ++-
>  4 files changed, 117 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/clk/sunxi/clk-bus-gates.c
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 7c4aee0..6293c65 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c

This hunk should be in patch 1:

> @@ -1000,9 +1005,8 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
>
>                 for (i = 0; i < SUNXI_DIVS_BASE_NAME_MAX_LEN - 1 &&
>                                                 clk_name[i] != '_' &&
> -                                               clk_name[i] != '\0'; i++) {
> +                                               clk_name[i] != '\0'; i++)
>                         base_name[i] = clk_name[i];
> -               }
>
>                 base_name[i] = '\0';
>                 factors.name = base_name;

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

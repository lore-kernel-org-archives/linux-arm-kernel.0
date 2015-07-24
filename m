From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 24 Jul 2015 19:18:43 +0800
Subject: [PATCH v4 5/7] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1437706925-3222-6-git-send-email-jamesjj.liao@mediatek.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <1437706925-3222-6-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CAGS+omB6LpttP_67iJsGrgLv6=B28FHq7RGbcRw_LaOd4LzCLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:02 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Most multimedia subsystem clocks will be accessed by multiple
> drivers, so it's a better way to manage these clocks in CCF.
> This patch adds clock support for MM, IMG, VDEC, VENC and VENC_LT
> subsystems.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8173.c      | 267 +++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/mt8173-clk.h |  97 +++++++++++-
>  2 files changed, 361 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index a72ce82..2cf6620 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -27,6 +27,10 @@ static DEFINE_SPINLOCK(mt8173_clk_lock);
>  static const struct mtk_fixed_clk fixed_clks[] __initconst = {
>         FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
>         FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
> +       FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", 130 * MHZ),
> +       FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", 130 * MHZ),
> +       FIXED_CLK(CLK_TOP_LVDS_PXL, "lvds_pxl", "lvdspll", 148.5 * MHZ),
> +       FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", 51.975 * MHZ),
>  };
>
>  static const struct mtk_fixed_factor top_divs[] __initconst = {
> @@ -699,6 +703,183 @@ static const struct mtk_composite peri_clks[] __initconst = {
>         MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
>  };
>
> +static const struct mtk_gate_regs cg_regs_4_8_0 = {

All of these regs tables can be __initconst.

Otherwise:
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

-Dan

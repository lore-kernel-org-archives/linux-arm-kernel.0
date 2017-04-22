From: net147@gmail.com (Jonathan Liu)
Date: Sun, 23 Apr 2017 00:46:24 +1000
Subject: [linux-sunxi] [PATCH v2 1/6] clk: sunxi-ng: Add sun4i/sun7i CCU
 driver
In-Reply-To: <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
Message-ID: <CANwerB3CySDKDF0Q5g4h5yaKBEF2S_rmp8ikR2HgGyf+RXzgAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On 27 March 2017 at 04:20, Priit Laes <plaes@plaes.org> wrote:
> +static struct ccu_nkmp pll_ve_clk = {
> +       .enable         = BIT(31),
> +       .n              = _SUNXI_CCU_MULT_OFFSET(8, 5, 0),
> +       .k              = _SUNXI_CCU_MULT(4, 2),
> +       .m              = _SUNXI_CCU_DIV(0, 2),
> +       .p              = _SUNXI_CCU_DIV(16, 2),
> +       .common         = {
> +               .reg            = 0x018,
> +               .hw.init        = CLK_HW_INIT("pll-ve",
> +                                             "hosc",
> +                                             &ccu_nkmp_ops,
> +                                             0),
> +       },
> +};

pll-ve is a NKMP clock in A10 but a NK clock in A20.

> +static const char *const hdmi_parents[] = { "pll-video0", "pll-video0-2x",
> +                                           "pll-vide01", "pll-video1-2x" };

"pll-vide01" should be "pll-video1".

Regards,
Jonathan

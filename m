From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 15 Sep 2016 20:42:33 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIEFSTTogaW14NTogQWRkIGNsb2NrcyBjb25maWd1?=
 =?UTF-8?B?cmF0aW9u?=
In-Reply-To: <1473934403-2726-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <1473934403-2726-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <1473961353.68713919@f429.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????, 15 ???????? 2016, 13:13 +03:00 ?? Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>:
>
>From: Kalle Kankare < kalle.kankare@vincit.fi >
>
>Add clocks configuration for CSI, FIRI and IEEE1588.
>
>Signed-off-by: Fabien Lahoudere < fabien.lahoudere@collabora.co.uk >
>---
>?drivers/clk/imx/clk-imx51-imx53.c      | 20 ++++++++++++++++++++
>?include/dt-bindings/clock/imx5-clock.h | 15 ++++++++++++++-
>?2 files changed, 34 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
>index 29d4c44..1e3c9ea 100644
>--- a/drivers/clk/imx/clk-imx51-imx53.c
>+++ b/drivers/clk/imx/clk-imx51-imx53.c
>@@ -126,6 +126,7 @@ static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
>?static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
>?static const char *step_sels[] = { "lp_apm", };
>?static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
>+static const char *ieee1588_sels[] = { "pll3_sw", "pll4_sw", "dummy" /* usbphy2_clk */, "dummy" /* fec_phy_clk */ };
>?
>?static struct clk *clk[IMX5_CLK_END];
>?static struct clk_onecell_data clk_data;
>@@ -543,6 +544,25 @@ static void __init mx53_clocks_init(struct device_node *np)
...

2 Shawn Guo: Since the change affects only on i.MX53 architecture,
I would ask to change the subject to i.MX53 if it possible.

---

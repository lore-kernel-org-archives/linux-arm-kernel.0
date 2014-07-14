From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 22:02:24 +0800
Subject: [PATCH v2 2/4] ARM: imx: clk-vf610: fix FlexCAN clock gating
In-Reply-To: <5a57efd52b0092ad61ff6a2b5bf68ba7@agner.ch>
References: <cover.1405322992.git.stefan@agner.ch>
 <94282392d8355ac25bb998b89032c1c980d5ccce.1405322992.git.stefan@agner.ch>
 <20140714133926.GH2197@dragon> <5a57efd52b0092ad61ff6a2b5bf68ba7@agner.ch>
Message-ID: <20140714140223.GI2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:55:29PM +0200, Stefan Agner wrote:
> There are two enable (gates) bits to enable the FlexCAN clocks: the
> first is in the divider register, the second in the clock gate register.
> For most clocks there is a divider in between, then it looks like this:
> 
> clk[VF610_CLK_ESDHC0_SEL] = imx_clk_mux("esdhc0_sel", CCM_CSCMR1, 16, 2,
> esdhc_sels, 4);
> clk[VF610_CLK_ESDHC0_EN] = imx_clk_gate("esdhc0_en", "esdhc0_sel",
> CCM_CSCDR2, 28);
> clk[VF610_CLK_ESDHC0_DIV] = imx_clk_divider("esdhc0_div", "esdhc0_en",
> CCM_CSCDR2, 16, 4);
> clk[VF610_CLK_ESDHC0] = imx_clk_gate2("eshc0", "esdhc0_div", CCM_CCGR7,
> CCM_CCGRx_CGn(1));
> 
> However, for FlexCAN no clock selection and no divider is available,
> hence its just a chain of an enable and gate register...

Ah, okay.  Thanks for the explanation.

Shawn

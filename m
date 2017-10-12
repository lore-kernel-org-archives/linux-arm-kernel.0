From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Oct 2017 10:40:54 -0300
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: switch lcdif pixel clock to
 video pll
In-Reply-To: <20171012133019.17086-1-p.zabel@pengutronix.de>
References: <20171012133019.17086-1-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5A69x6QrkStO1ijJq01Bi2utk-XoSS-ay8LV+YBqFPgng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 10:30 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> By default, the lcdif_pre_sel mux is switched to the pll3_pfd1_540m PFD
> source. If this mux is allowed to propagate rate changes to its parent,
> setting the LCDIF pixel clock rate to 9 MHz, as required by the LCD
> panel, will cause the pll3_pfd1_540m PFD to be switched away from its
> nominal rate to 288 MHz.
> This has no negative side effects, as there are no other children to
> this PFD. Still, to avoid surprises, it might be preferrable to switch
> to the designated video PLL (pll5_video_div) as clock source for the
> LCDIF pixel clock.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Makes sense:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

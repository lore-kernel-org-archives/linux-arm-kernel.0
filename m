From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Jul 2017 16:31:10 +0800
Subject: [PATCH] ARM: dts: imx: Correct B850v3 clock assignment
In-Reply-To: <20170630134337.18245-1-romain.perier@collabora.com>
References: <20170630134337.18245-1-romain.perier@collabora.com>
Message-ID: <20170712083109.GK3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 03:43:37PM +0200, Romain Perier wrote:
> From: Martyn Welch <martyn.welch@collabora.co.uk>
> 
> The IPU that drives HDMI must have its pre_sel set to pll2_pfd_396m
> to avoid stepping on the LVDS output's toes, as the PLL can't be clocked
> to the pixel clock and to the LVDS serial clock (3.5*pixel clock) at the
> same time.
> 
> As we are using ipu1_di0 and ipu2_di0, ensure both are switched to
> to pll2_pfd2_396m to avoid issues. The LDB driver will switch the
> required IPU to ldb_di1 when it uses it to drive LVDS.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

Applied, thanks.

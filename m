From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 16:49:06 +0800
Subject: [PATCH v2] ARM: dts: imx51-babbage: Fix the 26MHz clock modelling
In-Reply-To: <20171221152352.31597-1-fabio.estevam@nxp.com>
References: <20171221152352.31597-1-fabio.estevam@nxp.com>
Message-ID: <20171226084905.GK23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 01:23:52PM -0200, Fabio Estevam wrote:
> On imx51-babbage there is a 26MHz oscillator that is gated by GPIO3_1.
> 
> The output of this clock feeds audio codec clock and USB PHY clocks,
> which are gated by GPIO4_26 and GPIO2_1 respectively.
> 
> Fix the clock representation by properly using gpio-gate-clock.
> 
> The clock nodes can be moved out of the 'clocks' node.
> 
> Based on a commit from Lucas Stach for imx51-zii-rdu1 board.
> 
> This also fixes the following build warning with W=1:
> 
> arch/arm/boot/dts/imx51-babbage.dtb: Warning (unit_address_vs_reg): Node /clocks/codec_clock has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.

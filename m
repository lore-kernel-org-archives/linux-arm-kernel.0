From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 11:53:49 +0800
Subject: [PATCH v2] clk: imx25: Remove osc clock from driver
In-Reply-To: <1445839848-28323-1-git-send-email-mpa@pengutronix.de>
References: <1445839848-28323-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20151124035349.GE11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 07:10:48AM +0100, Markus Pargmann wrote:
> The 'osc' clock is already initialized by the fixed clock defined in
> imx25.dtsi. The imx25 clock driver tries to add this clock for a second
> time and fails with -EEXIST:
> 	i.MX clk 1: register failed with -17
> 
> As the clock is already properly setup in DT with a different driver, we
> can completely remove the handling in the imx25 clock driver.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Markus,

Please resend the patch with clock maintainers and list on copy.  If you
think it's a non-critical fix, I will queue it for v4.5-rc1.  Otherwise,
you ask clock maintainers to send it for v4.4-rc inclusion.

Shawn

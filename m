From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 16:50:40 +0800
Subject: [PATCH] ARM: dts: imx6: remove bogus interrupt-parent from CAAM
 node
In-Reply-To: <1452607470-12526-1-git-send-email-l.stach@pengutronix.de>
References: <1452607470-12526-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160128085039.GT9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 03:04:30PM +0100, Lucas Stach wrote:
> The interrupt-parent property is not needed as it is inherited from
> the parent bus and in the case of the CAAM node actively points to
> the wrong interrupt controller (GIC instead of GPC). This leads to
> the CAAM IRQs not getting unmasked at the GPC level, leaving them
> unable to wake the CPU from wait mode, potentially impacting
> performance of the CAAM unit when CPUidle is enabled.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.

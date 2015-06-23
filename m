From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 23 Jun 2015 18:23:13 +0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work
 simultaneously
In-Reply-To: <1435075417-28708-1-git-send-email-fabio.estevam@freescale.com>
References: <1435075417-28708-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1435076593.3155.30.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 23.06.2015, 13:03 -0300 schrieb Fabio Estevam:
> Currently it is not possible to have HDMI and LVDS working simultaneously,
> because both ports try to use PLL5.
> 
> Move the LVDS to PLL3_USB_OTG, so that HDMI and LVDS can be driven from
> independent sources.
> 
> With this change the LDB pixel clock goes to 68.57 MHz, which is still
> within the valid range for the HSD100PXN1 LVDS panel.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Please remember that on i.MX6QDL in general we can't change the LDB
clock parent without risking a breakdown in the divider:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313618.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313619.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313620.html

Has there been an erratum for this issue yet?

best regards
Philipp

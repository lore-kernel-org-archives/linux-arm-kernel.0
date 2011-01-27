From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 28 Jan 2011 07:34:02 +0800
Subject: [PATCH 1/2] ARM: imx53_loco: remove inavailable uart device
	and remove rts/cts support
In-Reply-To: <20110127092317.GU9041@pengutronix.de>
References: <1296119944-30485-1-git-send-email-richard.zhao@freescale.com>
	<20110127092317.GU9041@pengutronix.de>
Message-ID: <20110127233402.GA2239@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jan 27, 2011 at 10:23:17AM +0100, Sascha Hauer wrote:
> Richard,
> 
> Fabio posted a very similar patch. Please coordinate what should be done
> here.
Please merge Fabio patch first, I will send my second patch based on that again.

Thanks
Richard
> 
> Sascha
> 
> On Thu, Jan 27, 2011 at 05:19:03PM +0800, Richard Zhao wrote:
> > imx53_loco board only have one uart and the uart don't export rts/cts lines.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_loco.c |   20 +-------------------
> >  1 files changed, 1 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> > index d1348e0..d0ca65b 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> > @@ -41,29 +41,11 @@
> >  static iomux_v3_cfg_t mx53_loco_pads[] = {
> >  	MX53_PAD_CSI0_D10__UART1_TXD,
> >  	MX53_PAD_CSI0_D11__UART1_RXD,
> > -	MX53_PAD_ATA_DIOW__UART1_TXD,
> > -	MX53_PAD_ATA_DMACK__UART1_RXD,
> > -
> > -	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
> > -	MX53_PAD_ATA_DMARQ__UART2_TXD,
> > -	MX53_PAD_ATA_DIOR__UART2_RTS,
> > -	MX53_PAD_ATA_INTRQ__UART2_CTS,
> > -
> > -	MX53_PAD_ATA_CS_0__UART3_TXD,
> > -	MX53_PAD_ATA_CS_1__UART3_RXD,
> > -	MX53_PAD_ATA_DA_1__UART3_CTS,
> > -	MX53_PAD_ATA_DA_2__UART3_RTS,
> > -};
> > -
> > -static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
> > -	.flags = IMXUART_HAVE_RTSCTS,
> >  };
> >  
> >  static inline void mx53_loco_init_uart(void)
> >  {
> > -	imx53_add_imx_uart(0, &mx53_loco_uart_data);
> > -	imx53_add_imx_uart(1, &mx53_loco_uart_data);
> > -	imx53_add_imx_uart(2, &mx53_loco_uart_data);
> > +	imx53_add_imx_uart(0, NULL);
> >  }
> >  
> >  static inline void mx53_loco_fec_reset(void)
> > -- 
> > 1.6.3.3
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 11 Feb 2011 16:16:11 +0800
Subject: [PATCH] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <20110210131051.GU9041@pengutronix.de>
References: <1297245241-9864-1-git-send-email-julien.boibessot@free.fr>
	<20110210131051.GU9041@pengutronix.de>
Message-ID: <20110211081610.GA2100@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Feb 10, 2011 at 02:10:51PM +0100, Sascha Hauer wrote:
> Hi Julien,
> 
> The patch is probably fine. Can you provide a better commit log,
> something like 'fixes uart3 on $myboard'?
> 
> From looking at the datasheet it is not clear to me how the current pin
> configuration bahaves. It looks like a uart tx loopback in the iomuxer.
> Is this correct?
Yes. IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT is used to select input of
IPP_UART_RXD.  We always want it to connect to actual RXD pad.

I'll check mx50 iomux header for such issues.

Thanks
Richard
> 
> Sascha
> 
> On Wed, Feb 09, 2011 at 10:54:01AM +0100, julien.boibessot at free.fr wrote:
> > From: Julien Boibessot <julien.boibessot@armadeus.com>
> >
> > 
> > Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> > ---
> >  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> > index b6767f9..df531aa 100644
> > --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> > +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> > @@ -473,7 +473,7 @@
> >  #define _MX51_PAD_UART2_RXD__UART2_RXD		IOMUX_PAD(0x628, 0x238, 0, 0x09ec, 2, 0)
> >  #define _MX51_PAD_UART2_TXD__FIRI_RXD		IOMUX_PAD(0x62c, 0x23c, 1, 0x0000, 0, 0)
> >  #define _MX51_PAD_UART2_TXD__GPIO1_21		IOMUX_PAD(0x62c, 0x23c, 3, 0x0000, 0, 0)
> > -#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x09ec, 3, 0)
> > +#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x0000, 0, 0)
> >  #define _MX51_PAD_UART3_RXD__CSI1_D0		IOMUX_PAD(0x630, 0x240, 2, 0x0000, 0, 0)
> >  #define _MX51_PAD_UART3_RXD__GPIO1_22		IOMUX_PAD(0x630, 0x240, 3, 0x0000, 0, 0)
> >  #define _MX51_PAD_UART3_RXD__UART1_DTR		IOMUX_PAD(0x630, 0x240, 0, 0x0000, 0, 0)
> > -- 
> > 1.6.0.4
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

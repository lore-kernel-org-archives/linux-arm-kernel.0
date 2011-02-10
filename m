From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Feb 2011 21:55:07 +0100
Subject: [PATCH] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <4D53EE2C.2030209@free.fr>
References: <1297245241-9864-1-git-send-email-julien.boibessot@free.fr>
	<20110210131051.GU9041@pengutronix.de> <4D53EE2C.2030209@free.fr>
Message-ID: <20110210205507.GC2027@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 02:54:52PM +0100, Julien Boibessot wrote:
> Hi Sascha,
> 
> Sascha Hauer a ?crit :
> > The patch is probably fine. Can you provide a better commit log,
> > something like 'fixes uart3 on $myboard'?
> >   
> yes, I will try :-)
> > >From looking at the datasheet it is not clear to me how the current pin
> > configuration bahaves. It looks like a uart tx loopback in the iomuxer.
> > Is this correct?
> >   
> Well I just reverted the setting back to what it was on 2.6.36, before
> the recent MX51 iomux reorganisation.
> IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT register (0x09ec) shouldn't
> be used to configure UART2_TXD PAD, otherwise you overwrite current
> UART2_RXD PAD config.
> Current pin configuration seems to act as a kind of Tx->Rx loopback, yes.

Ok, would be good to have this in the commit log aswell.

Sascha

> 
> Without my patch, my board (not mainlined yet) can't receive anything on
> UART2 (used as console).
> 
> Julien
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

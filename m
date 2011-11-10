From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Nov 2011 11:20:37 +0100
Subject: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <4EBBA3D6.9000300@pengutronix.de>
References: <1320891899-16135-1-git-send-email-b39297@freescale.com>
 <4EBBA3D6.9000300@pengutronix.de>
Message-ID: <20111110102037.GC2503@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 11:13:42AM +0100, Marc Kleine-Budde wrote:
> On 11/10/2011 03:24 AM, wu guoxing wrote:
> > we only use the gpio function of mc9s08dz60 mcu chip, so just
> > add the gpio driver, as this mcu will never be used in other board.
> > 
> > Signed-off-by: Wu Guoxing <b39297@freescale.com>
> > ---
> > changes since v3:
> > 	1. set i2c client data before gpiochip_add
> 
> exchange the two in the remove function, too.
> First shut down the gpio chip, then unset set i2c client data.

and don't set clientdata to NULL.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/6c116f76/attachment.sig>

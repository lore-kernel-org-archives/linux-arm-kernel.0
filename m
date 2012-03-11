From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 11 Mar 2012 08:43:23 +0100
Subject: [PATCH v5 3/3] USB: ohci-nxp: Support for LPC32xx
In-Reply-To: <4F5BD5BE.3000808@antcom.de>
References: <1331408166-11607-1-git-send-email-stigge@antcom.de>
 <1331408166-11607-4-git-send-email-stigge@antcom.de>
 <20120310204955.GA14564@pengutronix.de>
 <4F5BD5BE.3000808@antcom.de>
Message-ID: <20120311074323.GA30894@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > And while we are at it: Could you also try replacing i2c_write()
> > with i2c_smbus_write_byte_data(isp1301_i2c_client, reg, val)?
> 
> Interestingly now, replacing i2c_write() calls with
> i2c_smbus_write_byte_data() did _not_ work (hardware initialization
> failure). I guess this is due to the differences between i2c and
> smbus, and the hardware only handles the former correctly?

Did you take into consideration that the smbus-call has (client, reg, val) as
arguments while i2c_write has (val, reg), that is you have to swap the
arguments?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/8ab88db7/attachment.sig>

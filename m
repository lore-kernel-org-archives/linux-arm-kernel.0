From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 27 Apr 2012 17:41:19 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <201204271708.53467.marex@denx.de>
References: <201204261326.29388.marex@denx.de>
 <201204270110.21377.marex@denx.de>
 <20120427145936.GD16504@pengutronix.de>
 <201204271708.53467.marex@denx.de>
Message-ID: <20120427154119.GF16504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> You can get a large list of i2c messages. In the current implementation, yes, 
> they're iterated in mxs_i2c_xfer_msg. Correct.
> 
> If you want to do DMA transfer do/from the i2c controller, you have to take all 
> these messages and create the chain of DMA transfers according to these 
> messages, correct?

This is what I wonder. I'd think one could work on a per message basis.
Regarding Figure 27-10, the first I2C write command could be sent
seperately (probably even via PIOQUEUE). The only thing to be chained is
the I2C read command and the actual reading of the data.

Just checked, the FSL driver does it basically this way, too.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/db3b5ffd/attachment.sig>

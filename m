From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 May 2018 20:31:43 +0200
Subject: [PATCH v2 2/2] i2c: busses: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180516071647.29277-3-peda@axentia.se>
References: <20180516071647.29277-1-peda@axentia.se>
 <20180516071647.29277-3-peda@axentia.se>
Message-ID: <20180529183143.ker46to34gr5hx3w@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 09:16:47AM +0200, Peter Rosin wrote:
> Because it looks neater.
> 
> For diolan, this allows factoring out some code that is now common
> between if and else.
> 
> For eg20t, pch_i2c_writebytes is always called with a write in
> msgs->flags, and pch_i2c_readbytes with a read.
> 
> For imx, i2c_imx_dma_write and i2c_imx_write are always called with a
> write in msgs->flags, and i2c_imx_read with a read.
> 
> For qup, qup_i2c_write_tx_fifo_v1 is always called with a write in
> qup->msg->flags.
> 
> For stu300, also restructure debug output for resends, since that
> code as a result is only handling debug output.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net> [diolan]
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [emf32 and imx]
> Acked-by: Linus Walleij <linus.walleij@linaro.org> [stu300]
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/61fb0766/attachment-0001.sig>

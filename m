From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Aug 2016 00:34:37 +0200
Subject: [PATCH] i2c: at91: fix support of the "alternative command"
 feature
In-Reply-To: <20160803145826.11927-1-ludovic.desroches@atmel.com>
References: <20160803145826.11927-1-ludovic.desroches@atmel.com>
Message-ID: <20160814223437.GG10501@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 04:58:26PM +0200, Ludovic Desroches wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> The "alternative command" feature was introduced with sama5d2 SoCs.
> 
> Its purpose is to let the hardware i2c controller automatically send the
> STOP condition on the i2c bus at the end of a data transfer.
> Without this feature, the i2c driver has to write the 'STOP' bit into the
> Control Register so the hardware i2c controller is triggered to send the
> STOP condition on the bus.
> 
> Using the "alternative command" feature requires to set the transfer data
> length into the 8bit DATAL field of the Alternative Command Register.
> Hence only data transfers up to 255 bytes can take advantage of the
> "alternative command" feature. For greater data transfer sizes, the driver
> should use the previous implementation, when the "alternative command"
> support was not implemented yet.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160815/6738ffc1/attachment.sig>

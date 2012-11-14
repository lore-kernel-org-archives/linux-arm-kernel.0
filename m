From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 09:59:44 +0100
Subject: [PATCH v2] i2c: i2c-gpio: fix name issue when i2c gpio node GT 1
In-Reply-To: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
References: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20121114085944.GA5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 03:51:17PM +0800, Bo Shen wrote:
> When i2c-gpio node number is greater than 1, the name for each is same
> So add the patch to fix it.
> 
> The adap->name printing information is add by myself
> 
> without this patch the log information is as following
> ---<8---
> adap->name = i2c-gpio-1
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c-gpio-1
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
> 
> with this patch, the log information is as following
> ---<8---
> adap->name = i2c.2
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c.3
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Applied to for-next, thanks.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/7bb0cd1e/attachment.sig>

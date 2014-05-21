From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 12:34:32 +0200
Subject: [PATCH] i2c: exynos5: add support for HSI2C on Exynos5260 SoC
In-Reply-To: <1398675598-25991-1-git-send-email-ch.naveen@samsung.com>
References: <1398675598-25991-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140521103432.GM2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:29:58PM +0530, Naveen Krishna Chatradhi wrote:
> HSI2C module on Exynos5260 differs from current modules in
> following ways:
> 1.  HSI2C on Exynos5260 has fifo_depth of 16bytes
> 2.  Module needs to be reset as a part of init sequence.
> 
> Hence, Following changes are involved.
> 1. Add a new compatible string and Updates the Documentation dt bindings.
> 2. Introduce a variant struct to support the changes in H/W
> 3. Reset the module during init. Thus, bringing the module back
> to default state irrespective of what firmware did with it.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ich.naveen@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

...

> -		fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(HSI2C_DEF_TXFIFO_LVL);
> +		trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
> +			(i2c->variant->fifo_depth * 3/4) : i2c->msg->len;
> +		fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(trig_lvl);
> +

Dunno why checkpatch missed the 'space around operator' issue, yet I
fixed it here...

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/db926f23/attachment-0001.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Dec 2017 23:33:19 +0100
Subject: [PATCH] i2c: Include GPIO consumer header in main include
In-Reply-To: <20171208133934.18038-1-linus.walleij@linaro.org>
References: <20171208133934.18038-1-linus.walleij@linaro.org>
Message-ID: <20171212223319.4fuzn3w6h4hwbcwt@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 02:39:34PM +0100, Linus Walleij wrote:
> It seems most users of <linux/i2c.h> pick up their
> dependency of <linux/gpio/consumer.h> from other paths but
> that is not a universal law, so include the header
> explicitly so we have struct gpio_desc available.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Not sure. Having GPIOs is not really a requirement for I2C. I tend to
think drivers using it should include this explicitly?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/de103bf0/attachment.sig>

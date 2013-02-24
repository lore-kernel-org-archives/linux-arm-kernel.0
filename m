From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 24 Feb 2013 01:16:21 +0100
Subject: [PATCH] i2c: s3c2410: check for NULL pinctrl handle
In-Reply-To: <201302231857.46445.heiko@sntech.de>
References: <201302231855.47560.heiko@sntech.de>
 <201302231857.46445.heiko@sntech.de>
Message-ID: <CACRpkdbV-CznfnbCbKkKpndjiG32V9yNdrF1F7M=4qe1EUroGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 23, 2013 at 6:57 PM, Heiko St?bner <heiko@sntech.de> wrote:

> When pinctrl is not built the fallback functions fail silently
> and emit either 0 error codes or NULL pinctrl handles.
>
> Therefore it's needed to also check for this NULL-handle when
> falling back to parsing the i2c gpios from devicetree.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

NAK.

This is not the right solution for this driver.

It uses pinctrl in a very simplistic way, just grabbing the
default handler.

After commit
ab78029ecc347debbd737f06688d788bd9d60c1d:
"drivers/pinctrl: grab default handles from device core"

The right solution is to simply revert commit
2693ac69880a33d4d9df6f128415b65e745f00ba
"i2c: s3c2410: Add support for pinctrl"

Tomasz are you OK with this, or will you add more
fine-grained pinctrl (like runtime PM etc) to this driver?

Yours,
Linus Walleij

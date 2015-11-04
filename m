From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 13:54:51 +0000
Subject: [PATCH 1/3] ASoC: rockchip: i2s: Add set the divider clock API
In-Reply-To: <1446434042-2139-1-git-send-email-wxt@rock-chips.com>
References: <1446434042-2139-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20151104135451.GB1717@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 11:14:00AM +0800, Caesar Wang wrote:
> In order to support more rates, add the divider clock api.

> As the input source clock to the module is MCLK_I2S,
> and by the divider of the module, the clock generator generates
> SCLK and LRCK to transmitter and receiver.

Why is this a requirement?  The clock to use as a source should normally
be specified via set_sysclk() and any internal dividers calculated
automatically by the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/4932e765/attachment.sig>

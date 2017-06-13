From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 21:46:53 +0100
Subject: [PATCH v1 2/4] ASoC: rockchip: i2s: add support for i2s bclk fs
 configuration
In-Reply-To: <1496998369-30556-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
 <1496998369-30556-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20170613204653.f6yfph5ixp4s42fh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:52:47PM +0800, Sugar Zhang wrote:

> +- rockchip,bclk-fs: configure the i2s bclk fs.

Rather than having a driver DT property for this the device should
implement a set_bclk_ratio() operation and let the ratio be set by the
machine driver.  The simple and graph cards may need extending for that,
I know they have MCLK configuration support already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/f6b8886a/attachment.sig>

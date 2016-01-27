From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Jan 2016 12:47:00 +0000
Subject: [PATCH v3 3/9] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <2073307.S3XLZp3hP0@diego>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <20160122171815.GD6588@sirena.org.uk>
 <56A57733.8020200@rock-chips.com> <2073307.S3XLZp3hP0@diego>
Message-ID: <20160127124700.GL6042@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:52:25AM +0100, Heiko St?bner wrote:
> Am Montag, 25. Januar 2016, 09:15:31 schrieb Jianqun Xu:
> > ? 23/01/2016 01:18, Mark Brown ??:

> > > controller driver that ensures that the clock is enabled.  The driver
> > > that manages the clock should be the one that uses it, like I say this
> > > means you should add the code to enable the clock to the CODEC driver if
> > > the CODEC driver needs the clock enabled.

> > But the property responsible to the factor, not care if the mclk source
> > clock is enabled or not. So does the simple-card driver can add support
> > to enable/disable mclk ?

> The mclk-input is part of the codec I'd think. So you'd want the clocks-
> property in the i2c entry describing the codec itself and implement the clk 
> operations in the codec driver as well.

> See codec-drivers for da7213, da7218,max98090 and many more for reference.

Yes, as I have said repeatedly including in the mail quoted above the
CODEC is using the clock so should be managing it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/aa1b82ef/attachment.sig>

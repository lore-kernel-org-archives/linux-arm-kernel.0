From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 11:24:53 +0100
Subject: [PATCH 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM simulated
 from USP
In-Reply-To: <CAGsJ_4xNdxFWyN6NUEL36W9n+4Cj=01+QGi+xaeODm9u8pdP9A@mail.gmail.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
 <20130719181313.GT9858@sirena.org.uk>
 <CAGsJ_4xNdxFWyN6NUEL36W9n+4Cj=01+QGi+xaeODm9u8pdP9A@mail.gmail.com>
Message-ID: <20130725102453.GZ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 05:32:12PM +0800, Barry Song wrote:
> 2013/7/20 Mark Brown <broonie@kernel.org>:

> > Also what exactly is the rate being set - can the driver just figure
> > this out automatically from the sample rate?

> here it is generating the right pcm clock by an internal DIVISOR in USP module.

> For USP_MODE2:
> 30:21 (R/W) USP_CLK_DIVISOR 10?h0 USP serial clock divider

> For USP_TX_FRAME_CTRL:
> 31:30 (R/W) USP_CLK_DIVISOR 2?h0 This is the two bit [11:10] of
> USP_CLK_DIVISOR in USP_MODE2

> for figuring this out automatically from the sample rate, do you mean
> a lookup table for common sample rate?

That or just calculating it - if you know the input rate and know the
output rate you need then for a simple divisor it should be possible to
calculate the required value.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/9d324ca6/attachment.sig>

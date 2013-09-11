From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 12:14:09 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <20130911110543.GA7393@intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan> <522FC0DC.9030708@intel.com>
 <20130911095552.GI29403@sirena.org.uk>
 <20130911110543.GA7393@intel.com>
Message-ID: <20130911111409.GO29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 02:05:43PM +0300, Mika Westerberg wrote:

> I'll also look into converting the existing I2C client drivers to use this
> method. One question, though, is it better to have the conversion in the
> same patch that introduces the I2C core runtime PM change or as a separate
> patch?

In theory it ought to be part of the same patch but in practice a brief
bit of bisection breakage on a single branch is probably worth the ease
of review from my point of view, others may disagree though.  Like I say
I think you'll need to convert SPI at the same time due to the devices
with both buses sharing code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/14a872ce/attachment-0001.sig>

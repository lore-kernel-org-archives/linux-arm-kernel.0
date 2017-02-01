From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Feb 2017 10:53:29 +0000
Subject: [PATCH v1] ASoC: bcm2835: Remove redundant channel checking code
 in hw_params
In-Reply-To: <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
References: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
 <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
Message-ID: <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 03:45:03PM +1100, Matt Flax wrote:

> This redundant channel count check may seem like it will not cause
> any problems however some sound cards (such as the 8 channel
> AudioInjector Octo sound card) require the execution of the
> bcm2835_i2s_hw_params function when channels_max in the
> bcm2835_i2s_dai structure has been increased to 8.

> As the channel checking code in bcm2835_i2s_hw_params is redundant
> and stops certain cards from working it has been removed.

If those cards add support for higher channel counts they should be
adding real support for that in the driver, not just hacking out
defensive code.  If the device can usefully do 8 channels then modify
the driver to do 8 channels.  Otherwise people are going to need to
modify the driver anyway to remove the limits in the constraints.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/69b6d45f/attachment.sig>

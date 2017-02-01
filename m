From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Feb 2017 11:14:15 +0000
Subject: [alsa-devel] [PATCH v1] ASoC: bcm2835: Remove redundant channel
 checking code in hw_params
In-Reply-To: <d91986b0-4deb-6d2a-6000-34b4072baed2@flatmax.org>
References: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
 <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
 <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
 <d91986b0-4deb-6d2a-6000-34b4072baed2@flatmax.org>
Message-ID: <20170201111415.hdk432uddm3t3w4d@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 10:05:18PM +1100, Matt Flax wrote:
> On 01/02/17 21:53, Mark Brown wrote:

> > If those cards add support for higher channel counts they should be
> > adding real support for that in the driver, not just hacking out
> > defensive code.  If the device can usefully do 8 channels then modify
> > the driver to do 8 channels.  Otherwise people are going to need to
> > modify the driver anyway to remove the limits in the constraints.

> Indeed the AudioInjector Octo sound card is currently operating @ 8 channels
> out on the bcm2835 silicon. It has been tested on both the Pi 2 and Pi 3.

> Do you mean that I should increase bcm2835_i2s_dai.channels_max to 8 ?

Yes, implementing it properly is fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/2603fd0d/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Mar 2016 11:33:16 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F17684.2010307@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
Message-ID: <20160323113316.GH2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 05:44:52PM +0100, Stefan Roese wrote:
> On 22.03.2016 17:35, Thomas Petazzoni wrote:

> >Has there been any discussion on whether dynamically adding the MBus
> >window is a good idea, as opposed to statically defining it in the
> >board .dts ?

> Yes. My 1st patch version (still RFC) used fixed MBus windows instead:

> http://www.spinics.net/lists/linux-spi/msg06536.html

> Mark suggested to use dynamic windows, so that one area could be
> used for all SPI devices by switching (re-configuring) the MBus
> window:

> http://www.spinics.net/lists/linux-spi/msg06537.html

No, there's two separate things here.  The big problem with what you
originally sent was that you were defining a window per SPI device but
this is a part of the SPI controller so having to change windows per
device is just going to make the code more complex.  There's also the
separate issue of where any MBus windows we get come up with.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/52f9216e/attachment.sig>

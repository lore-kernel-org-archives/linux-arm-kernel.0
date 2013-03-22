From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Mar 2013 12:48:00 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <514C43B4.1040403@metafoo.de>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <20130322111704.GZ4977@n2100.arm.linux.org.uk>
 <20130322112859.GL22890@opensource.wolfsonmicro.com>
 <514C43B4.1040403@metafoo.de>
Message-ID: <20130322114759.GM22890@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 12:42:44PM +0100, Lars-Peter Clausen wrote:
> On 03/22/2013 12:28 PM, Mark Brown wrote:

> > We need support for both cyclic and non-cyclic devices, one doesn't
> > preclude the other and both kinds of hardware exist.  Cyclic is much
> > more common and generally more desirable but that doesn't mean that
> > hardware designers always provide it.

> The idea was to only have support for the cyclic dmaengine API in the ASoC
> PCM driver and deal with the emulation of cyclic transfers for hardware,
> which does not implement it, at the dmaengine layer.

Perhaps I'm misremembering but I thought there was pushback on that on
the basis that there are few if any other users of cyclic DMA so nobody
else cares or wants to deal with the hassle?  A quick grep seems not to
turn up any other users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/e46380c3/attachment.sig>

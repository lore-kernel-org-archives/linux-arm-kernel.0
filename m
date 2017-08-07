From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Aug 2017 12:48:37 +0100
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
In-Reply-To: <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
References: <20170807104101.3540159-1-arnd@arndb.de>
 <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
 <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
Message-ID: <20170807114837.3bqsroayi3sipf4h@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 01:36:09PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 7, 2017 at 1:20 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 07, 2017 at 12:40:44PM +0200, Arnd Bergmann wrote:
> >> When the audio driver selects CONFIG_PXA_SSP to be a loadable
> >> module on a platform other than PXA, and the PXA SPI driver
> >> is built-in, we get a link error in the SPI driver:

> > Why doesn't this cause problems on PXA?

> On PXA, we 'make' descends into arch/arm/plat-pxa/, where ssp.o
> is located. On other ARM platforms (I guess except for MMP),
> PLAT_PXA is not set, and on non-ARM architectures, we can't
> get there anyway.

Still missing a few steps of reasoning here...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/94962595/attachment.sig>

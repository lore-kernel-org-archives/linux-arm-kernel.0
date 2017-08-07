From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Aug 2017 13:36:09 +0200
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
In-Reply-To: <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
References: <20170807104101.3540159-1-arnd@arndb.de>
 <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
Message-ID: <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 1:20 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 07, 2017 at 12:40:44PM +0200, Arnd Bergmann wrote:
>> When the audio driver selects CONFIG_PXA_SSP to be a loadable
>> module on a platform other than PXA, and the PXA SPI driver
>> is built-in, we get a link error in the SPI driver:
>
> Why doesn't this cause problems on PXA?

On PXA, we 'make' descends into arch/arm/plat-pxa/, where ssp.o
is located. On other ARM platforms (I guess except for MMP),
PLAT_PXA is not set, and on non-ARM architectures, we can't
get there anyway.

      Arnd

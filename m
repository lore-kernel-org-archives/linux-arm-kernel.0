From: broonie@kernel.org (Mark Brown)
Date: Sat, 12 Jul 2014 20:49:03 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <53C153FF.4090705@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de>
Message-ID: <20140712194903.GB6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 05:27:59PM +0200, Lars-Peter Clausen wrote:
> On 07/11/2014 03:45 PM, Arnd Bergmann wrote:

> >As a prerequisite for moving s3c64xx into multiplatform configurations,
> >we need to change the smartq audio driver to stop using hardcoded
> >gpio numbers from the header file, and instead pass the gpio data
> >through platform_data.

> This should be using the gpiod API. The gpiod API allows you to pass the
> GPIOs without having to add a platform_data struct.

OTOH that's a more invasive change that's harder to do mechanically -
I'm not sure it's sensible to insist on someone doing it for generic
cleanups (rather than actively working with the particular platform).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140712/1a08ede5/attachment.sig>

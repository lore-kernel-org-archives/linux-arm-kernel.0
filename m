From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 30 Nov 2015 16:39:50 +0800
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
In-Reply-To: <CAFd313zqimQtG8epeo3U7gzxWRf0hqO4K8hOFy4UK-6pG5GcJg@mail.gmail.com>
References: <rsahu@apm.com> <1447665169-14003-1-git-send-email-rsahu@apm.com>
 <CAFd313zqimQtG8epeo3U7gzxWRf0hqO4K8hOFy4UK-6pG5GcJg@mail.gmail.com>
Message-ID: <20151130083950.GA7792@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 02:06:03PM +0530, Rameshwar Sahu wrote:
> On Mon, Nov 16, 2015 at 2:42 PM,  <rsahu@apm.com> wrote:
> > From: Rameshwar Prasad Sahu <rsahu@apm.com>
> >
> > This patch implements support for APM X-Gene SoC CRC32C h/w accelerator driver
> > and adds CRC32C computations support in dmaengine framework. APM X-Gene SoC has
> > DMA engine capable of performing CRC32C computations.
> >
> > v2 changes:
> >         1. Added helper function in dmaengine framework
> >         2. Documented CRC32C support in Documentations/dmaengine/provider.txt
> >         3. Fixed algo name
> >         4. Fixed coding style issues
> >
> > Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> > ---
> >
> > Rameshwar Prasad Sahu (3):
> >   dmaengine: Add support for new feature CRC32C computations
> >   dmaengine: xgene-dma: Add support for CRC32C computations via DMA
> >     engine
> >   Crypto: Add support for APM X-Gene SoC CRC32C h/w accelerator driver
> >
> >  Documentation/dmaengine/provider.txt |    3 +
> >  drivers/crypto/Kconfig               |    8 +
> >  drivers/crypto/Makefile              |    1 +
> >  drivers/crypto/xgene-crc32c.c        |  234 +++++++++++++++++++++++++
> >  drivers/dma/dmaengine.c              |    2 +
> >  drivers/dma/xgene-dma.c              |  314 ++++++++++++++++++++++++++++++++--
> >  include/linux/dmaengine.h            |   13 ++
> >  7 files changed, 560 insertions(+), 15 deletions(-)
> >  create mode 100755 drivers/crypto/xgene-crc32c.c
> 
> Any Comments on above patchset ??

The main user of crc32c is lib/libcrc32c.c.  Unfortunately it is
entire synchronous so it won't be able to use your crc32c driver
at all.

So who is going to be using this?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

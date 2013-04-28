From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 28 Apr 2013 23:30:14 +0800
Subject: [PATCH] Support fsl-dcp crypto coprocessor
In-Reply-To: <1366710460-11637-1-git-send-email-cb@sgoc.de>
References: <1366710460-11637-1-git-send-email-cb@sgoc.de>
Message-ID: <CAAQ0ZWSYNJg4+rDNjO-JcwzbWfzh7sJXJFuUp3fCNguYC28p7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

You need to check MAINTAINERS to get the mailing list and maintainers
of crypto subsystem.

CRYPTO API
M:      Herbert Xu <herbert@gondor.apana.org.au>
M:      "David S. Miller" <davem@davemloft.net>
L:      linux-crypto at vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
S:      Maintained
F:      Documentation/crypto/
F:      arch/*/crypto/
F:      crypto/
F:      drivers/crypto/
F:      include/crypto/

It's nice to have linux-arm-kernel on Cc, but the patch should really be
sent to people and mailing list above.  After all, Herbert will
eventually pick up the patch after it gets reviewed on linux-crypto
list.

On Tue, Apr 23, 2013 at 11:47:40AM +0200, Christoph G. Baumann wrote:
> From: "Christoph G. Baumann" <cb@sgoc.de>
>
> The following patch is a port of the original driver from Freescale to
> the current mainline. The patch was tested under 3.7.

The patch should be developed and tested against the latest kernel
version, saying v3.9.

Will look into the patch in another day.

Shawn

>
> Signed-off-by: "Christoph G. Baumann" <cb@sgoc.de>
> ---
>  drivers/staging/crypto/Kconfig               |   15 +
>  drivers/staging/crypto/Makefile              |    1 +
>  drivers/staging/crypto/fsl-dcp.c             | 1817 ++++++++++++++++++++++++++
>  drivers/staging/crypto/fsl-dcp.h             |  739 +++++++++++
>  include/linux/fsl/fsl-dcp_bootstream_ioctl.h |   32 +
>  5 files changed, 2604 insertions(+)
>  create mode 100644 drivers/staging/crypto/Kconfig
>  create mode 100644 drivers/staging/crypto/Makefile
>  create mode 100644 drivers/staging/crypto/fsl-dcp.c
>  create mode 100644 drivers/staging/crypto/fsl-dcp.h
>  create mode 100644 include/linux/fsl/fsl-dcp_bootstream_ioctl.h

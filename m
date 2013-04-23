From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 23 Apr 2013 14:34:08 +0200
Subject: [PATCH] Support fsl-dcp crypto coprocessor
In-Reply-To: <1366710460-11637-1-git-send-email-cb@sgoc.de>
References: <1366710460-11637-1-git-send-email-cb@sgoc.de>
Message-ID: <20130423123408.GB1366@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 11:47:40AM +0200, Christoph G. Baumann wrote:
> From: "Christoph G. Baumann" <cb@sgoc.de>
> 
> The following patch is a port of the original driver from Freescale to
> the current mainline. The patch was tested under 3.7.
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

IMHO it doesn't make any sense to push this into staging. The Freescale
kernel is full of drivers which are not ready for mainline yet.

Until now, it was a good strategy to wait until some code is needed,
then clean it up, adapt it to the right kernel APIs and push it into
non-staging mainline.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

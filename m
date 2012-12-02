From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Dec 2012 13:33:50 +0900
Subject: [PATCH 2/2] ASoC: Samsung: Do not register samsung audio dma
 device as pdev
In-Reply-To: <1354356447-16784-3-git-send-email-padma.v@samsung.com>
References: <1354356447-16784-1-git-send-email-padma.v@samsung.com>
 <1354356447-16784-3-git-send-email-padma.v@samsung.com>
Message-ID: <20121202043349.GX17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 03:37:27PM +0530, Padmavathi Venna wrote:

>  sound/soc/samsung/dma.c         |   24 ++++++------------------
>  sound/soc/samsung/dma.h         |    3 +++
>  sound/soc/samsung/i2s.c         |    3 +++
>  sound/soc/samsung/smdk_wm8994.c |    7 +++++--
>  4 files changed, 17 insertions(+), 20 deletions(-)

This is fine in principle but it's going to break every Samsung based
platform except the SMDK with WM8994 as only machine driver updated to
reflect the changed DAI name is that one, the others need updating too.

This includes pretty much all the platforms I actively work on...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121202/2249480c/attachment.sig>

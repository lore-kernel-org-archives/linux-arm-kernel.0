From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Aug 2014 16:29:24 +0200
Subject: [PATCH 1/2] imx-drm: imx-ldb: fix kernel Oops in imx_ldb_unbind()
In-Reply-To: <1408441795-24719-2-git-send-email-shawn.guo@freescale.com>
References: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
 <1408441795-24719-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <1408458564.2899.17.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 19.08.2014, 17:49 +0800 schrieb Shawn Guo:
> Unbinding imx-ldb driver on imx6q-sabresd board triggers a kernel Oops
> as below.
> 
> $ echo 2000000.aips-bus\:ldb\@020e0008 > unbind
[...]
> Fix the issue by checking if the LDB channel is actually created/valid
> before calling into its connector/encoder's destroy() function.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Tested on Nitrogen6X with LVDS panel.

regards
Philipp

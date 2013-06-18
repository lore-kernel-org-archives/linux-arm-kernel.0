From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Jun 2013 16:45:41 +0800
Subject: [PATCH 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1371521418-3003-2-git-send-email-b35083@freescale.com>
References: <1371521418-3003-1-git-send-email-b35083@freescale.com>
 <1371521418-3003-2-git-send-email-b35083@freescale.com>
Message-ID: <20130618084539.GB28384@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 10:10:18AM +0800, Jingchang Lu wrote:
>   Add Freescale Vybrid VF610 I2C controller support to
> imx I2C driver framework.
>   Some operation is different from imx I2C controller.
> The register offset, the i2c clock divider value table,
> the module enabling(I2CR_IEN) which is just invert with imx,
> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> but w0c on imx.
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 144 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 125 insertions(+), 19 deletions(-)

It seems to me that the patch introduces section mismatch warnings.

WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

Shawn

From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 10:14:24 +0800
Subject: [PATCH v2 2/2] tty: serial: imx: don't reinit clock in
 imx_setup_ufcr()
In-Reply-To: <1346400167-24669-1-git-send-email-dirk.behme@de.bosch.com>
References: <1346400167-24669-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120831021422.GD7726@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 10:02:47AM +0200, Dirk Behme wrote:
> Remove the clock configuration from imx_setup_ufcr(). This
> isn't needed here and will cause garbage output if done.
> 
> To be be sure that we only touch the bits we want (TXTL and RXTL)
> we have to mask out all other bits of the UFCR register. Add
> one non-existing bit macro for this, too (bit 6, DCEDTE on i.MX6).
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Troy Kisky <troy.kisky@boundarydevices.com>
> CC: Xinyu Chen <xinyu.chen@freescale.com>
> CC: <stable@vger.kernel.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> Changes in v2: Instead of disabling imx_setup_ufcr() with an
> ifndef CONFIG_SERIAL_CORE_CONSOLE, remove the unneeded clock 
> configuration from imx_setup_ufcr() itself as proposed by Troy Kisky.
> 
> Note: If this patch is accepted, it should go to the same stable
> kernels as patch #1 of this series. So most probably 3.4 and 3.5.

In such cases, you should repost the series instead of this patch only,
so that maintainer can apply them a little easier.  Let's see if
Greg is fine to apply patch #1 from the early post and #2 from here.

-- 
Regards,
Shawn

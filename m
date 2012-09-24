From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Sep 2012 13:06:58 +0800
Subject: [PATCH] spi/imx: set the inactive state of the clock according
 to the clock polarity
In-Reply-To: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
References: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120924050655.GA27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 10:55:11AM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
> 
> There are SPI devices which need a SPI clock with active low polarity and
> high inactive state.
> 
> Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
> according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:
> 
> DT without "spi-cpol" = 0 = clock active high polarity = inactive state low
> DT with    "spi-cpol" = 1 = clock active low  polarity = inactive state high
> 
> Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

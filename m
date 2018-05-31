From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 31 May 2018 12:12:59 +0300
Subject: [PATCH v2] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
In-Reply-To: <20180526021238.30753-1-andrew.smirnov@gmail.com>
References: <20180526021238.30753-1-andrew.smirnov@gmail.com>
Message-ID: <3bd6b3fb-8512-df27-8361-e53841597c55@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Make sure that MX51_PAD_GPIO1_1 does not remain configure as
> ALT0/SD1_WP (it is out of reset). This is needed because of external
> pull-up resistor attached to that pad that, when left unchanged, will
> drive SD1_WP high preventing eSDHC1/eMMC from working correctly.
> 
> To fix that add a pinmux configuration line configureing the pad to
> function as a GPIO. While we are at it, add a corresponding
> output-high GPIO hog in an effort to minimize current consumption.
> 
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Tested-By: Nikita Yushchenko <nikita.yoush@cogentembedded.com

Tested on 8.9'' RDU1. Without this patch, eMMC does not work, get

[   40.801367] mmc0: Timeout waiting for hardware interrupt.
[   40.806789] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
... <dump follows>

With this patch, eMMC works correctly.

Nikita

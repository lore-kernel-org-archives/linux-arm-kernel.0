From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 16:26:27 +0800
Subject: [PATCH v3 4/4] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
In-Reply-To: <20120427082930.GC826@shlinux2.ap.freescale.net>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-4-git-send-email-b29396@freescale.com>
 <20120427073504.GS17184@pengutronix.de>
 <20120427082930.GC826@shlinux2.ap.freescale.net>
Message-ID: <20120427082623.GU2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 04:29:31PM +0800, Dong Aisheng wrote:
> You meant add provide_dummies call in imx*_soc_init call?
> We could do it but there might be a case that some boards are converted
> to use pinctrl while others still not but they're based on the same soc.
> For examples, 4 mx53 boards and we may not be able to convert them all at
> the same time.
> 
Only non-DT boot will call imx*_soc_init, while DT boot will not.  And
imx pinctrl only supports DT.

-- 
Regards,
Shawn

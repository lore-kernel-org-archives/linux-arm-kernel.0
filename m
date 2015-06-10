From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Wed, 10 Jun 2015 07:36:00 -0700
Subject: [PATCH 4/6] mmc: sdhci-esdhc-imx: config watermater levles and
 burst lengths
In-Reply-To: <1433926244-29244-5-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-5-git-send-email-haibo.chen@freescale.com>
Message-ID: <55784B50.6030101@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haibo,

On 06/10/2015 01:50 AM, Haibo Chen wrote:
> i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
> DDR mode. So the I/O speed improve a lot compare to SD3.0
> 
> The default burst length is 8, if we don't change this value, in
> HS400 mode, when we do eMMC read operation, we can find that the
> clock signal will stop for a period of time. This means the speed
> of data moving on AHB bus is slower than I/O speed. So we should
> improve the speed of data moving on AHB bus.
> 
> For imx7d usdhc, this patch set the burst length as 16, and set
> watermater levle as 64. The test result is the clock signal has
> no stop during the eMMC HS400 operation. For other imx usdhc, remain

"watermark", not "watermater".

> the default value: burst length as 8, watermater level as 16.
> 
Same goes for the subject.

Also "levels", not "levles", so:
	mmc: sdhci-esdhc-imx: config watermark level and burst length

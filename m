From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 28 Dec 2012 19:17:43 +0800
Subject: [PATCH 0/2] ARM: cfa10036: Switch SPI to gpio bitbanging
In-Reply-To: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121228111742.GB19447@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 10:54:46PM +0100, Maxime Ripard wrote:
> Hi Shawn,
> 
> Here is a patchset that moves the spi bus we use to bitbanging. This is needed
> because the DAC found on this bus is actually using a 12 bits wordlength, while
> the imx28 spi controler can only handle 4, 8 or 16 bits per words.
> 
Will try to apply the second patch after the first one gets applied on spi tree.

Shawn

> Maxime Ripard (2):
>   spi: spi-gpio: Add checks for the dt properties
>   ARM: dts: cfa10049: Change the SPI3 bus to spi-gpio
> 
>  arch/arm/boot/dts/imx28-cfa10049.dts |   78 ++++++++++++++++++----------------
>  drivers/spi/spi-gpio.c               |   23 ++++++++--
>  2 files changed, 62 insertions(+), 39 deletions(-)
> 
> -- 
> 1.7.9.5
> 

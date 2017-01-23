From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 18:10:06 +0800
Subject: [PATCH 1/1] ARM: dts: imx6dl: fix GPIO4 range
In-Reply-To: <1484734191-18556-1-git-send-email-sebastien.szymanski@armadeus.com>
References: <1484734191-18556-1-git-send-email-sebastien.szymanski@armadeus.com>
Message-ID: <20170123101004.GQ5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:09:51AM +0100, S?bastien Szymanski wrote:
> GPIO4_11 is on pin 152(MX6DL_PAD_KEY_ROW2) and not on pin
> 151(MX6DL_PAD_KEY_ROW1).
> 
> I found the error while booting a mainline kernel on APF6S SoM and
> noticed the following message:
> 
> [    2.609337] imx6dl-pinctrl 20e0000.iomuxc: pin MX6DL_PAD_KEY_ROW1
> already requested by 20a8000.gpio:105; cannot claim for 20a8000.gpio:107
> [    2.621884] imx6dl-pinctrl 20e0000.iomuxc: pin-151 (20a8000.gpio:107)
> status -22
> [    2.629303] spi_imx 2008000.ecspi: Can't get CS GPIO 107
> 
> With this patch, the message is gone and spi_imx driver probes correctly.
> 
> Fixes: bb728d662bed ("ARM: dts: add gpio-ranges property to iMX GPIO
> controllers")
> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>

Applied, thanks.

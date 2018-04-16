From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 15:11:18 +0800
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Let the codec control MCLK
 pinctrl
In-Reply-To: <1521059786-9177-1-git-send-email-festevam@gmail.com>
References: <1521059786-9177-1-git-send-email-festevam@gmail.com>
Message-ID: <20180416071117.GB25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 05:36:26PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> sgtl5000 codec needs MCLK clock to be present so that it can
> successfully read/write via I2C.
> 
> In the case of wandboard, MCLK is provided via
> MX6QDL_PAD_GPIO_0__CCM_CLKO1 pad. 
> 
> Move the MCLK pinctrl from hog group to the codec group, so that the
> codec clock can be present prior to reading the codec ID.
> 
> This avoids the following error that happens from time to time:
> 
> [    2.484443] sgtl5000 1-000a: Error reading chip id -6
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.

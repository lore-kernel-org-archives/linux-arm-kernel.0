From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Feb 2014 09:40:36 +0800
Subject: [PATCH v2] ARM: dts: imx6sl-evk: Keep VGEN1 regulator always
 enabled
In-Reply-To: <1392808428-26143-1-git-send-email-festevam@gmail.com>
References: <1392808428-26143-1-git-send-email-festevam@gmail.com>
Message-ID: <20140220014034.GN3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 08:13:48AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On imx6sl-evk board the VGEN1 regulator powers up the NVCC_1P2V domain of the
> imx6sl SoC, so we need to keep it always powered.
> 
> According to imx6sl datasheet the GPIO block has three supplies:
> NVCC33_IO, NVCC18_IO and NVCC_1P2V and it states that:
> "All digital I/O supplies (NVCC_xxxx) must be powered under normal conditions
> whether the associated I/O pins are in use or not"
> 
> This problem has been observed by the fact that a GPIO connected to an LED could
> not work when the PMIC driver was enabled.
> 
> Keeping VGEN1 regulator always enabled fixes the problem.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Apr 2015 17:26:14 +0300
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150429142614.GE2258@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shenwei Wang,

On Wed, Apr 29, 2015 at 09:14:41AM -0500, Shenwei Wang wrote:
> There are 4 versions of the timer hardware on Freescale MXC hardware.
> --Version 0: MX1/MXL
> --Version 1: MX21, MX27.
> --Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q
> --Version 3: MX6DL, MX6SX
> 
> This patch has removed the SoC related codes, and implemented the driver
> directly upon the hardware timer IP version.
> 
> The new driver can be installed via device tree or the direct function
> call to mxc_timer_init in order to support imx legacy systems like MX21
> and MX27.
> 
> For the device tree implementation, the driver is compatible with the current
> bindings like "fsl,imx6q-gpt", but for future dts file, the string like
> "fsl,imx-gpt-v2" without SoC information is recommended.

That is not the usual convention for IP block versions.

Please Cc the devicetree list (added).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

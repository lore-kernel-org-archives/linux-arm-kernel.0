From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Sep 2013 23:08:25 +0800
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
In-Reply-To: <1378688408-8689-1-git-send-email-festevam@gmail.com>
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
Message-ID: <20130909150823.GB5815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 10:00:07PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Allow booting a device tree kernel on mx6solo.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6s.dtsi   | 82 ++++++++++++++++++++++++++++++++++++++++++

The imx6s is not another SoC but just imx6dl with one core fused out.
This is the exactly same case as imx6q and imx6d. See commit dc13ba2
(ARM: imx: do not bring up unavailable cores) for how we handle that
in kernel.

Are you running into any problem to boot imx6s wandboard with
imx6dl-wandboard.dtb?

Shawn

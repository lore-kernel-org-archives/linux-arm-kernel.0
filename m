From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 12 Nov 2018 17:20:00 +0000
Subject: [PATCH 1/1] pinctrl: imx: fix NO_PAD_CTL setting for MMIO pads
In-Reply-To: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
References: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <a4683f6e901225d3125be8dd15c8857ac02ac79f.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-11-12 at 15:25 +0000, A.s. Dong wrote:
> After patch b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support"),
> NO_PAD_CTL pads map are not skipped anymore which results in
> a possible memory corruption. As we actually only need to create config
> maps for SCU pads and MMIO pads which are not using the default config
> (a.k.a IMX_NO_PAD_CTL), so let's add a proper check before creating
> the config maps. And during MMIO pads parsing, we also need update the
> list_p point as SCU case to ensure the pin data next parsed is correct.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Tested-by: Leonard Crestez <leonard.crestez@nxp.com>

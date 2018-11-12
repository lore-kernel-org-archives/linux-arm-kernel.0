From: martin@kaiser.cx (Martin Kaiser)
Date: Mon, 12 Nov 2018 16:47:55 +0100
Subject: [PATCH 1/1] pinctrl: imx: fix NO_PAD_CTL setting for MMIO pads
In-Reply-To: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
References: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181112154755.msekhs5xg5ylopkz@viti.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

your patch looks good to me.

Thus wrote A.s. Dong (aisheng.dong at nxp.com):

> After patch b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support"),
> NO_PAD_CTL pads map are not skipped anymore which results in
> a possible memory corruption. As we actually only need to create config
> maps for SCU pads and MMIO pads which are not using the default config
> (a.k.a IMX_NO_PAD_CTL), so let's add a proper check before creating
> the config maps. And during MMIO pads parsing, we also need update the
> list_p point as SCU case to ensure the pin data next parsed is correct.

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

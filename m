From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Nov 2018 14:52:50 +0100
Subject: [PATCH 1/1] pinctrl: imx: fix NO_PAD_CTL setting for MMIO pads
In-Reply-To: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
References: <1542036051-23840-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdajsAde9YL6G+2WZi+TUXd4QH5TfmwMcXCg=nL4eUJGLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 4:25 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

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

Patch applied with all the test tags!

Yours,
Linus Walleij

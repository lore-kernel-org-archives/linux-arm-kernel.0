From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 7 Apr 2013 11:32:45 -0300
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <20130407142610.GE11898@S2101-09.ap.freescale.net>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
 <20130407071028.GD11898@S2101-09.ap.freescale.net>
 <CAOMZO5Bxfj9ZGrVOcNirsVHFLWaHWBdkFpKSiVQ9iS4paT0Y6g@mail.gmail.com>
 <20130407142610.GE11898@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5A-nwmb=6G-D_2LBNsPYH4C8Z686BjS3vd3WhzvnDFfqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 7, 2013 at 11:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> That's expected, as the pin ID gets re-numbered based on offset of
> mux/conf register, so that we can determine the pin ID at runtime and
> avoid encoding it in device tree.

but debug messages seems buggy now:

Prior to the patch we had:

imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_D21

and now we have:

imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_A17

MX6Q_PAD_EIM_A17 has nothing to do with I2C, so we should print
MX6Q_PAD_EIM_A17 when we are actually configuring MX6Q_PAD_EIM_D21.

Also, where does the 19 offset in the  imx6q_pads enum come from?

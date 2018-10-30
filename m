From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 30 Oct 2018 14:13:33 +0000
Subject: [PATCH RESEND V3 0/2] pinctrl: imx: add imx8qxp pinctrl support
In-Reply-To: <1540908354-26809-1-git-send-email-aisheng.dong@nxp.com>
References: <1540908354-26809-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM0PR04MB4211450F716707D2EE7112FD80CC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -----Original Message-----
> From: A.s. Dong
> Sent: Tuesday, October 30, 2018 10:11 PM
> To: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linus.walleij at linaro.org;
> shawnguo at kernel.org; stefan at agner.ch; A.s. Dong <aisheng.dong@nxp.com>;
> dongas86 at gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>
> Subject: [PATCH RESEND V3 0/2] pinctrl: imx: add imx8qxp pinctrl support
> 
> Rebased with latest pinctrl/for-next tree, compiling and function tested on
> IMX6Q SDB.
> 

Can you please check if this version can be applied?

Regards
Dong Aisheng

> This patch series adds i.MX8QXP pinctrl support which is based on the pad
> service provided by SCU firmware.
> 
> The binding part is also merged into scu binding doc according to Rob's
> suggestion.
> https://www.spinics.net/lists/arm-kernel/msg680738.html
> 
> v2->v3:
>  * Pad name update (add IMX8QXP prefix)
> 
> v1->v2:
>  * scu firmware headfile path update
>  * structure name and api usage update
>  * move SCU Pad API implementation into driver
>  * add binding headfile pad-imx8qxp.h
> 
> Dong Aisheng (2):
>   pinctrl: fsl: add scu based pinctrl support
>   pinctrl: imx: add imx8qxp driver
> 
>  drivers/pinctrl/freescale/Kconfig           |  11 +
>  drivers/pinctrl/freescale/Makefile          |   2 +
>  drivers/pinctrl/freescale/pinctrl-imx.c     | 425 ++++++++++------
>  drivers/pinctrl/freescale/pinctrl-imx.h     |  67 ++-
>  drivers/pinctrl/freescale/pinctrl-imx8qxp.c | 232 +++++++++
>  drivers/pinctrl/freescale/pinctrl-scu.c     | 121 +++++
>  include/dt-bindings/pinctrl/pads-imx8qxp.h  | 751
> ++++++++++++++++++++++++++++
>  7 files changed, 1439 insertions(+), 170 deletions(-)  create mode 100644
> drivers/pinctrl/freescale/pinctrl-imx8qxp.c
>  create mode 100644 drivers/pinctrl/freescale/pinctrl-scu.c
>  create mode 100644 include/dt-bindings/pinctrl/pads-imx8qxp.h
> 
> --
> 2.7.4

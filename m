From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Nov 2018 00:20:45 -0200
Subject: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
In-Reply-To: <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
 <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, Nov 7, 2018 at 11:24 PM Anson Huang <anson.huang@nxp.com> wrote:

> Regarding the fec2 settings in imx7d-sdb.dts, originally it uses Rev-A board (but some nodes are
> using Rev-B board), in this patch, I clean up all the settings in imx7d-sdb.dts using Rev-B board,
> so below is added to imx7d-sdb.dts for Rev-B board, and in imx7d-sdb-reva.dts I have to
> delete it, since Rev-A board has no this pin.
>
> -       pinctrl-0 = <&pinctrl_enet2>;
> +       pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_epdc0_en>;
> +       pinctrl-assert-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;

"pinctrl-assert-gpios" only exists in the NXP vendor kernel, so you
cannot use such property in mainline.

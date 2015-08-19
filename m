From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Aug 2015 08:51:36 +0200
Subject: [PATCH 8/8] pinctrl: freescale: imx: fix system crash if enable
 two pinctl instances
In-Reply-To: <1439912939-17535-8-git-send-email-aalonso@freescale.com>
References: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
 <1439912939-17535-8-git-send-email-aalonso@freescale.com>
Message-ID: <20150819065136.GD9999@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Aug 18, 2015 at 10:48:59AM -0500, Adrian Alonso wrote:
> From: Robin Gong <b38343@freescale.com>
> 
> Remove 'static' for 'grp_index', otherwise, it cause the groups whose number is
> smaller than the number of groups of the last pinctl instance never to be
> intialized, thus cause system crash as below
> 
> [    0.661012] [<802a6cb0>] (strcmp) from [<802cc80c>] (imx_dt_node_to_map+0x58/0x208)
> [    0.668879] [<802cc80c>] (imx_dt_node_to_map) from [<802cbe24>] (pinctrl_dt_to_map+0x174/0x2b0)
> [    0.677654] [<802cbe24>] (pinctrl_dt_to_map) from [<802c8f18>] (pinctrl_get+0x100/0x424)
> [    0.685878] [<802c8f18>] (pinctrl_get) from [<802c9510>] (pinctrl_register+0x26c/0x480)
> [    0.694104] [<802c9510>] (pinctrl_register) from [<802ccf3c>] (imx_pinctrl_probe+0x580/0x6e8)
> [    0.702706] [<802ccf3c>] (imx_pinctrl_probe) from [<80351b58>] (platform_drv_probe+0x44/0xa4)
> [    0.711455] [<80351b58>] (platform_drv_probe) from [<803503ec>] (driver_probe_device+0x174/0x2b4)
> [    0.720405] [<803503ec>] (driver_probe_device) from [<803505fc>] (__driver_attach+0x8c/0x90)
> [    0.728982] [<803505fc>] (__driver_attach) from [<8034e930>] (bus_for_each_dev+0x6c/0xa0)
> [    0.737381] [<8034e930>] (bus_for_each_dev) from [<8034fb88>] (bus_add_driver+0x148/0x1f0)
> [    0.745804] [<8034fb88>] (bus_add_driver) from [<80350c00>] (driver_register+0x78/0xf8)
> [    0.753880] [<80350c00>] (driver_register) from [<800097d0>] (do_one_initcall+0x8c/0x1d4)
> [    0.762282] [<800097d0>] (do_one_initcall) from [<80987dac>] (kernel_init_freeable+0x144/0x1e4)
> [    0.771061] [<80987dac>] (kernel_init_freeable) from [<806d9c7c>] (kernel_init+0x8/0xe8)
> [    0.779285] [<806d9c7c>] (kernel_init) from [<8000f628>] (ret_from_fork+0x14/0x2c)
> [    0.786981] Code: e3520000 e5e32001 1afffffb e12fff1e (e4d03001)

When you add a crash log (which is fine) then please don't remove
relevant parts (here the beginning). I'm sure you have a wrong fix here
(as Markus already pointed out). Which machine did this happen on?

Also as general rule it's nice to have the fixes at the beginning of the
series. This allows the maintainer to take the fixes already now and
postpone the cleanups and new features until the next merge window.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

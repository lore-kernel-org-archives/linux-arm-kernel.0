From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 21 Jun 2012 09:16:35 +0800
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <CAGsJ_4xZM0DYV6YLLUyQ1fd-s9DOvKAZ94UcNwGaUN3xTR97Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/14 Wolfram Sang <w.sang@pengutronix.de>:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Barry Song <barry.song@lianlab.org>

> ---
>
> Based on v3.5-rc2. Only build tested, I don't have a OF based device
> around at the moment.
>
> @Peter: Why does ocores do the device registration manually via
> platform_data instead of using board_info?
>
> ?drivers/i2c/busses/i2c-cpm.c ? ? ? ? ? ? ? ?| ? ?5 -----
> ?drivers/i2c/busses/i2c-designware-platdrv.c | ? ?1 -
> ?drivers/i2c/busses/i2c-gpio.c ? ? ? ? ? ? ? | ? ?2 --
> ?drivers/i2c/busses/i2c-ibm_iic.c ? ? ? ? ? ?| ? ?3 ---
> ?drivers/i2c/busses/i2c-imx.c ? ? ? ? ? ? ? ?| ? ?2 --
> ?drivers/i2c/busses/i2c-mpc.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?drivers/i2c/busses/i2c-mxs.c ? ? ? ? ? ? ? ?| ? ?2 --
> ?drivers/i2c/busses/i2c-ocores.c ? ? ? ? ? ? | ? ?2 --
> ?drivers/i2c/busses/i2c-omap.c ? ? ? ? ? ? ? | ? ?2 --
> ?drivers/i2c/busses/i2c-pnx.c ? ? ? ? ? ? ? ?| ? ?2 --
> ?drivers/i2c/busses/i2c-pxa.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?drivers/i2c/busses/i2c-s3c2410.c ? ? ? ? ? ?| ? ?1 -
> ?drivers/i2c/busses/i2c-sh_mobile.c ? ? ? ? ?| ? ?1 -
> ?drivers/i2c/busses/i2c-tegra.c ? ? ? ? ? ? ?| ? ?2 --
> ?drivers/i2c/busses/i2c-versatile.c ? ? ? ? ?| ? ?1 -
> ?drivers/i2c/busses/i2c-xiic.c ? ? ? ? ? ? ? | ? ?2 --
> ?drivers/i2c/i2c-core.c ? ? ? ? ? ? ? ? ? ? ?| ? ?3 +++
> ?17 files changed, 3 insertions(+), 30 deletions(-)

-barry

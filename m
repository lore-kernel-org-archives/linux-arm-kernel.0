From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 14 Jun 2012 08:53:49 +0100
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <CAOh2x=n3uzc3K1oMtOKicuiQoZLYu4QVTY0gEPmSFsw3_R=u9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 10:12 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---


> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0506fef..cf3b23c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -147,7 +147,6 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "failure adding adapter\n");
> ? ? ? ? ? ? ? ?goto err_free_irq;
> ? ? ? ?}
> - ? ? ? of_i2c_register_devices(adap);
>
> ? ? ? ?return 0;

For SPEAr,

Reviewed-by: Viresh Kumar <viresh.linux@gmail.com>

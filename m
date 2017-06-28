From: dianders@chromium.org (Doug Anderson)
Date: Tue, 27 Jun 2017 22:38:41 -0700
Subject: [PATCH v3 1/2] spi: rockchip: Set GPIO_SS flag to enable Slave
 Select with GPIO CS
In-Reply-To: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <CAD=FV=V3_jntAn=qSzV-Lvs1qz5-EuWRNYT1=SsUuNqhHpsoJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 27, 2017 at 9:38 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> The rockchip spi still requires slave selection when using GPIO CS.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/spi/spi-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index bab9b13..52ea160 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -749,6 +749,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>         master->transfer_one = rockchip_spi_transfer_one;
>         master->max_transfer_size = rockchip_spi_max_transfer_size;
>         master->handle_err = rockchip_spi_handle_err;
> +       master->flags = SPI_MASTER_GPIO_SS;
>
>         rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
>         if (IS_ERR(rs->dma_tx.ch)) {

Reviewed-by: Douglas Anderson <dianders@chromium.org>

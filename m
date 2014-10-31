From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 Oct 2014 22:14:15 -0700
Subject: [PATCH v2] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
In-Reply-To: <1414727409-6765-1-git-send-email-addy.ke@rock-chips.com>
References: <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <1414727409-6765-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=VegP+6QDEmiU6J9GuT9Sv7yJ_1bQiNhTfFqcXs6hsUkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Thu, Oct 30, 2014 at 8:50 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> +static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> +{
> +       struct device_node *np = host->dev->of_node;
> +       int sdio_id0;
> +
> +       if (!of_property_read_u32(np, "rockchip,sdio-interrupt-slot0",
> +                                 &sdio_id0))
> +               host->sdio_id0 = sdio_id0;

This function is only run on rk3288 and on all rk3288 SoCs this value
is exactly 8.  Just replace this with:

  /* SDIO IRQ shows up as if it were slot 8 on rk3288 SoCs */
  host->sdio_id0 = 8;

From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 25 Oct 2014 10:28:15 -0200
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5D_B3shtVo7==FvpiWKVELP-wDMAVnS+yLvSjotrdTUAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 8:07 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> When a firmware cannot be found for the SDMA engine then we can
> continue with the inernal ROM firmware.
>
> The meaning of this message is frequently asked for, so make clear
> that the driver still works with the internal ROM firmware and reduce
> the loglevel from err to info.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>
> changes since v1:
> - instead of removing the message make it more clear

I know this has been posted a long time ago and agree that it would be
useful to change this dev_err code into dev_info:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

>
>  drivers/dma/imx-sdma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index c75679d..d79eaad 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1259,7 +1259,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
>         unsigned short *ram_code;
>
>         if (!fw) {
> -               dev_err(sdma->dev, "firmware not found\n");
> +               dev_info(sdma->dev, "external firmware not found, using ROM firmware\n");
> +               /*
> +                * In this case we just use the ROM firmware.
> +                */
>                 return;
>         }
>
> --
> 1.8.5.2

From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 20 Jan 2014 12:28:40 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140120122840.36520f37@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> When a firmware cannot be found for the SDMA engine then we can
> continue with the inernal ROM firmware.
> 
> The meaning of this message is frequently asked for, so make clear
> that the driver still works with the internal ROM firmware and reduce
> the loglevel from err to info.
> 
In case user space firmware loading 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
> 
> changes since v1:
> - instead of removing the message make it more clear
> 
>  drivers/dma/imx-sdma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index c75679d..d79eaad 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1259,7 +1259,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
>  	unsigned short *ram_code;
>  
>  	if (!fw) {
> -		dev_err(sdma->dev, "firmware not found\n");
> +		dev_info(sdma->dev, "external firmware not found, using ROM firmware\n");
> +		/*
> +		 * In this case we just use the ROM firmware.
> +		 */
>  		return;
>  	}
>  


-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

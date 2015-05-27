From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 14:31:46 +0200
Subject: [PATCH 1/2] soc: mediatek: PMIC wrap: Fix clock rate handling
In-Reply-To: <1432633064-16839-2-git-send-email-s.hauer@pengutronix.de>
References: <1432633064-16839-1-git-send-email-s.hauer@pengutronix.de>
 <1432633064-16839-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeJWB-ih=ukjf_S7VovNmDvVBfqpEJ0FQCpmWyE+_+ybGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-26 11:37 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> replace chipselect extension values based on SPI clock with hardcoded SoC
> specific values.
>
> The PMIC wrapper has the ability of extending the chipselects by configurable
> amounts of time. We configured the values based on the rate of SPI clock, but
> this is wrong. The delays should be configured based on the internal PMIC clock
> that latches the values from the SPI bus to the internal PMIC registers. By
> default this clock is 24MHz. Other clock frequencies are for debugging only
> and can be removed from the driver.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 42 ++++++------------------------------
>  1 file changed, 7 insertions(+), 35 deletions(-)
>

Applied, thanks.
Matthias

From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Jan 2015 22:39:40 -0200
Subject: [PATCH] pinctrl: imx25: fix numbering for pins
In-Reply-To: <1422402356-12171-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150127232440.GK29856@pengutronix.de>
 <1422402356-12171-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5BZ=N=kEbLp-pZjMWcTHGaAXLQ612qm-v2qpwDzn_eQNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 9:45 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> The pin id for a given tuple listed in a fsl,pins property is calculated
> by dividing the first entry (which is also a register offset) by 4.
> As the first available register is at offset 0x8 and configures the pad
> MX25_PAD_A10 the right id for this pin is 2. All other pins are off by
> one, too.
>
> This patch drops the definition MX25_PAD_RESERVE1 (together with its
> only use) and decrements all following values by 1.
>
> Fixes: b4a87c9b966f ("pinctrl: pinctrl-imx: add imx25 pinctrl driver")
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks

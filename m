From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 15:45:59 +0530
Subject: [PATCH v7 6/6] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180726065331.6186-7-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-7-o.rempel@pengutronix.de>
Message-ID: <CABb+yY1Fbj2GiO_zjwnvNFutjX_fRpxnuEoeu6Z3s4NAv2ugbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
<o.rempel@pengutronix.de> wrote:

.....

> +
> +/* Control Register */
> +#define IMX_MU_xCR             0x24
> +/* Transmit Interrupt Enable */
> +#define IMX_MU_xCR_TIEn(x)     BIT(20 + (3 - (x)))
> +/* Receive Interrupt Enable */
> +#define IMX_MU_xCR_RIEn(x)     BIT(24 + (3 - (x)))
> +
> +#define IMX_MU_CHANS   4u
> +
The 'u' unnecessarily refreshes my knowledge of C  :)


> +struct imx_mu_con_priv {
> +       int                     irq;
> +       unsigned int            idx;
> +       char                    *irq_desc;
>
Having      char  irq_desc[16];    seems simpler than free/kfree upon
each startup/shutdown. Simply use snprintf() in probe().

The rest of the driver seems fine.

Cheers!

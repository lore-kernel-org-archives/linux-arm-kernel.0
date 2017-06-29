From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jun 2017 20:00:55 +0200
Subject: [PATCH v2 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <21ca1ecb-39ac-5d43-71a2-d566974ab577@st.com>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
 <1497958890-5530-4-git-send-email-pierre-yves.mordret@st.com>
 <20170627205135.greh3baskzi4zetk@pengutronix.de>
 <21ca1ecb-39ac-5d43-71a2-d566974ab577@st.com>
Message-ID: <20170629180055.ga6jgonch6dhowyi@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 29, 2017 at 02:40:44PM +0000, Pierre Yves MORDRET wrote:
> >> +	/* Arbitration loss */
> >> +	if (status & STM32F7_I2C_ISR_ARLO) {
> >> +		dev_err(dev, "<%s>: Arbitration loss\n", __func__);
> > 
> > Drop this. Arbitration loss is not an error and it shouldn't pollute the
> > kernel log.
> > 
> 
> I would like to keep it as indication though.
> Agree with dev_warn ?

No, dev_debug is ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

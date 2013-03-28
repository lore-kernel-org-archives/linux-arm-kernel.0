From: marex@denx.de (Marek Vasut)
Date: Thu, 28 Mar 2013 23:58:08 +0100
Subject: [PATCH v2] iio: mxs-lradc: Do hardware initialization earlier
In-Reply-To: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201303282358.08630.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

> We need to initialize hardware before registering the touchscreen. Else,
> we end up setting registers in mxs_lradc_ts_open(), getting called just
> after registering the touchscreen with input_register_device() and by
> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
> correct configuration.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Marek Vasut <marex@denx.de>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut

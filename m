From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 04 Jul 2016 19:36:50 +0200
Subject: [PATCH 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <1467640052-6770-3-git-send-email-gabriel.fernandez@st.com>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1467653810.2224.77.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

Am Montag, den 04.07.2016, 15:47 +0200 schrieb gabriel.fernandez at st.com:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>

Isn't Maxime the author of this driver?

> The STM32 MCUs family IPs can be reset by accessing some registers
> from the RCC block.
> 
> The list of available reset lines is documented in the DT bindings.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-stm32.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 drivers/reset/reset-stm32.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 03dc1bb..3776b7b 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
[...]
> +static const struct reset_control_ops stm32_reset_ops = {
> +	.assert		= stm32_reset_assert,
> +	.deassert	= stm32_reset_deassert,

Are the registers not readable, or did you choose not to
implement .status on purpose?

regards
Philipp

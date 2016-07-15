From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 15 Jul 2016 15:23:13 -0500
Subject: [PATCH 3/4] qcom: ipq4019: ASoC tlmm/pinctrl support
In-Reply-To: <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160715202313.GA3509@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:37:05PM +0530, njaigane at codeaurora.org wrote:
> From: Jaiganesh Narayanan <njaigane@codeaurora.org>
> 
> This patch adds the tlmm/pinctrl support for IPQ4019 ASoC.
> 
> Signed-off-by: Jaiganesh Narayanan <njaigane@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c | 116 +++++++++++++++++++++++++--------
>  1 file changed, 88 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index b68ae42..bc22597 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
> @@ -283,6 +283,18 @@ enum ipq4019_functions {
>  	qca_mux_blsp_uart0,
>  	qca_mux_blsp_spi1,
>  	qca_mux_blsp_spi0,
> +	qca_mux_i2s_rx_mclk,
> +	qca_mux_i2s_rx_bclk,
> +	qca_mux_i2s_rx_fsync,
> +	qca_mux_i2s_rxd,
> +	qca_mux_i2s_tx_mclk,
> +	qca_mux_i2s_tx_bclk,
> +	qca_mux_i2s_tx_fsync,
> +	qca_mux_i2s_txd1,
> +	qca_mux_i2s_txd2,
> +	qca_mux_i2s_txd3,
> +	qca_mux_i2s_spdif_out,
> +	qca_mux_i2s_spdif_in,

You'll also need to add all of these to the
Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt

I was also going to suggest just using qca_i2s and having a single function, but
it seems like there is at least 1 pin that supports more than one i2s mode.

Regards,
Andy

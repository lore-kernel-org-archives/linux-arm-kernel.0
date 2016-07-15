From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 12:15:15 -0700
Subject: [PATCH 3/4] qcom: ipq4019: ASoC tlmm/pinctrl support
In-Reply-To: <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160715191515.GC13516@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 15 Jul 00:07 PDT 2016, njaigane at codeaurora.org wrote:

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
[..]
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

I would recommend reducing this to "i2s_rx", "i2s_tx", "spdif_rx"
and "spdif_tx", as this will make the dts cleaner.

Regards,
Bjorn

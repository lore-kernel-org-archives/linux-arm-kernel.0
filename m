From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:07:52 -0700
Subject: [PATCH v3 4/6] clk: meson-axg: Add AO Clock and Reset controller
 driver
In-Reply-To: <20180328025050.221585-5-yixun.lan@amlogic.com>
References: <20180328025050.221585-1-yixun.lan@amlogic.com>
 <20180328025050.221585-5-yixun.lan@amlogic.com>
Message-ID: <152304527293.94378.2019634000949753214@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Yixun Lan (2018-03-27 19:50:48)
> +       [CLKID_AO_SAR_ADC_CLK]  = &axg_saradc_gate,
> +};
> +
> +static struct clk_hw_onecell_data axg_aoclk_onecell_data = {

const?

> +       .hws = {
> +               [CLKID_AO_REMOTE]       = &remote_ao.hw,
> +               [CLKID_AO_I2C_MASTER]   = &i2c_master_ao.hw,
> +               [CLKID_AO_I2C_SLAVE]    = &i2c_slave_ao.hw,
> +               [CLKID_AO_UART1]        = &uart1_ao.hw,
> +               [CLKID_AO_UART2]        = &uart2_ao.hw,
> +               [CLKID_AO_IR_BLASTER]   = &ir_blaster_ao.hw,
> +               [CLKID_AO_SAR_ADC]      = &saradc_ao.hw,
> +               [CLKID_AO_CLK81]        = &ao_clk81.hw,
> +               [CLKID_AO_SAR_ADC_SEL]  = &axg_saradc_mux.hw,
> +               [CLKID_AO_SAR_ADC_DIV]  = &axg_saradc_div.hw,
> +               [CLKID_AO_SAR_ADC_CLK]  = &axg_saradc_gate.hw,
> +       },
> +       .num = NR_CLKS,
> +};
> +
> +static struct meson_aoclk_data axg_aoclkc_data = {

const?

> +       .reset_reg      = AO_RTI_GEN_CNTL_REG0,
> +       .num_reset      = ARRAY_SIZE(axg_aoclk_reset),
> +       .reset          = axg_aoclk_reset,
> +       .num_clks       = ARRAY_SIZE(axg_aoclk_regmap),
> +       .clks           = axg_aoclk_regmap,
> +       .hw_data        = &axg_aoclk_onecell_data,
> +};

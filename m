From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 30 Oct 2017 16:40:07 +0100
Subject: [RESEND PATCH v2 1/2] soc: amlogic: add Meson GX VPU Domains
 driver
In-Reply-To: <1509208583-30349-2-git-send-email-narmstrong@baylibre.com>
References: <1509208583-30349-1-git-send-email-narmstrong@baylibre.com>
 <1509208583-30349-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAPDyKFpCf50XRowGe3X5KpmhKrb99NTxOUQtz4RN4aemAVAJCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

[...]

> +
> +       pm_genpd_init(&vpu_hdmi_pd.genpd, &simple_qos_governor,
> +                     meson_gx_pwrc_vpu_get_power(&vpu_hdmi_pd));
> +

This means that you may initialize the genpd in powered on state.

For that scenario, I think you will hit a clock unprepare/disable
in-balance issue when genpd calls your ->power_off() callback, simply
because you didn't call clk_prepare_enable() for the clocks first.

[...]

Kind regards
Uffe

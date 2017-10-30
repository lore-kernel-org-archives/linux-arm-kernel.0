From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 Oct 2017 17:47:46 +0100
Subject: [RESEND PATCH v2 1/2] soc: amlogic: add Meson GX VPU Domains
 driver
In-Reply-To: <CAPDyKFpCf50XRowGe3X5KpmhKrb99NTxOUQtz4RN4aemAVAJCA@mail.gmail.com>
References: <1509208583-30349-1-git-send-email-narmstrong@baylibre.com>
 <1509208583-30349-2-git-send-email-narmstrong@baylibre.com>
 <CAPDyKFpCf50XRowGe3X5KpmhKrb99NTxOUQtz4RN4aemAVAJCA@mail.gmail.com>
Message-ID: <4f236610-22d5-b3ef-a5a7-1aba579a0791@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/2017 16:40, Ulf Hansson wrote:
> Hi Neil,
> 
> [...]
> 
>> +
>> +       pm_genpd_init(&vpu_hdmi_pd.genpd, &simple_qos_governor,
>> +                     meson_gx_pwrc_vpu_get_power(&vpu_hdmi_pd));
>> +
> 
> This means that you may initialize the genpd in powered on state.
> 
> For that scenario, I think you will hit a clock unprepare/disable
> in-balance issue when genpd calls your ->power_off() callback, simply
> because you didn't call clk_prepare_enable() for the clocks first.
> 
> [...]
> 
> Kind regards
> Uffe
> 

Hi,

I added a "powered" attribute to trace if power-on was done by the driver, but I only protected the shutdown call.... I should indeed protect it in the power_off call instead.

Neil

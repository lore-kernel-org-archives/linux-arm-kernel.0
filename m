From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 18 Nov 2018 15:05:45 +0100
Subject: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
Message-ID: <CAFBinCB-X0T5mhOkPV=xaKs=RimFZedA8LuqJigD2FfKb28nrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs shows a pretty summary and each clock can be measured
> individually aswell.
>
> This patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.
>
> Changes since v2 at [2]:
> - Removed all reference to GX
> - Added compatibles for meson8/meson8b
> - Used Martin's suggestions on the divider naming
> - Added Martin's meson8/meson8b clk id table
> - Added Martin's fixes to support 32bit SoCs
thank you for the updates Neil!

here's the output from Odroid-C1:
# cat /sys/kernel/debug/meson-clk-msr/measure_summary
 clock                     rate    precision
---------------------------------------------
ring_osc_out_ee0              0    +/-3125Hz
ring_osc_out_ee1              0    +/-3125Hz
ring_osc_out_ee2              0    +/-3125Hz
a9_ring_osck                  0    +/-3125Hz
vid_pll               148497596    +/-4807Hz
clk81                 159372396    +/-5208Hz
encp                  148497596    +/-4807Hz
encl                          0    +/-3125Hz
eth_rmii              125000000    +/-3906Hz
amclk                         0    +/-3125Hz
fec_clk_0                     0    +/-3125Hz
fec_clk_1                     0    +/-3125Hz
fec_clk_2                     0    +/-3125Hz
a9_clk_div16           74998438    +/-3125Hz
hdmi_sys                      0    +/-3125Hz
rtc_osc_clk_out           32813    +/-3125Hz
i2s_clk_in_src0               0    +/-3125Hz
clk_rmii_from_pad             0    +/-3125Hz
hdmi_ch0_tmds          74248438    +/-3125Hz
lvds_fifo                     0    +/-3125Hz
sc_clk_int                    0    +/-3125Hz
sar_adc                 1140625    +/-3125Hz
mpll_clk_test_out             0    +/-3125Hz
audac_clkpi                   0    +/-3125Hz
vdac                          0    +/-3125Hz
sdhc_rx                       0    +/-3125Hz
sdhc_sd                       0    +/-3125Hz
mali                          0    +/-3125Hz
hdmi_tx_pixel          74250000    +/-3125Hz
vdin_meas                     0    +/-3125Hz
pcm_sclk                      0    +/-3125Hz
pcm_mclk                      0    +/-3125Hz
eth_rx_tx                     0    +/-3125Hz
pwm_d                         0    +/-3125Hz
pwm_c                  24000000    +/-3125Hz
pwm_b                         0    +/-3125Hz
pwm_a                         0    +/-3125Hz
pcm2_sclk                     0    +/-3125Hz
ddr_dpll_pt                   0    +/-3125Hz
pwm_f                         0    +/-3125Hz
pwm_e                         0    +/-3125Hz
hcodec                        0    +/-3125Hz
usb_32k_alt                   0    +/-3125Hz
gpio                          0    +/-3125Hz
vid2_pll                      0    +/-3125Hz
mipi_csi_cfg                  0    +/-3125Hz

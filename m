From: padma.kvr@gmail.com (Padma Venkat)
Date: Thu, 13 Jun 2013 08:32:23 +0530
Subject: [PATCH V6 6/6] clk: exynos5250: Add enum entries for divider
 clock of i2s1 and i2s2
In-Reply-To: <20130612164553.26381.41398@quantum>
References: <1371024463-303-1-git-send-email-padma.v@samsung.com>
 <1371024463-303-7-git-send-email-padma.v@samsung.com>
 <20130612164553.26381.41398@quantum>
Message-ID: <CAAgF-BfEvBcrm186t6U9Tp4r64wB3sEsy6hoXMQi=dHJgncvfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Jun 12, 2013 at 10:15 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Padmavathi Venna (2013-06-12 01:07:43)
>> This patch adds enum entries for div_i2s1 and div_i2s2 which are
>> required for i2s1 and i2s2 controllers.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>
> Looks good.  Did you want me to take the clk patches or just gathering
> Acks?

Please take the patches :).

Thanks
Padma

>
> Regards,
> Mike
>
>> ---
>>  drivers/clk/samsung/clk-exynos5250.c |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
>> index 5c97e75..7c68850 100644
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>> @@ -87,6 +87,7 @@ enum exynos5250_clks {
>>         sclk_mmc0, sclk_mmc1, sclk_mmc2, sclk_mmc3, sclk_sata, sclk_usb3,
>>         sclk_jpeg, sclk_uart0, sclk_uart1, sclk_uart2, sclk_uart3, sclk_pwm,
>>         sclk_audio1, sclk_audio2, sclk_spdif, sclk_spi0, sclk_spi1, sclk_spi2,
>> +       div_i2s1, div_i2s2,
>>
>>         /* gate clocks */
>>         gscl0 = 256, gscl1, gscl2, gscl3, gscl_wa, gscl_wb, smmu_gscl0,
>> @@ -291,8 +292,8 @@ struct samsung_div_clock exynos5250_div_clks[] __initdata = {
>>         DIV(none, "div_pcm1", "sclk_audio1", DIV_PERIC4, 4, 8),
>>         DIV(none, "div_audio2", "mout_audio2", DIV_PERIC4, 16, 4),
>>         DIV(none, "div_pcm2", "sclk_audio2", DIV_PERIC4, 20, 8),
>> -       DIV(none, "div_i2s1", "sclk_audio1", DIV_PERIC5, 0, 6),
>> -       DIV(none, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
>> +       DIV(div_i2s1, "div_i2s1", "sclk_audio1", DIV_PERIC5, 0, 6),
>> +       DIV(div_i2s2, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
>>         DIV(sclk_pixel, "div_hdmi_pixel", "sclk_vpll", DIV_DISP1_0, 28, 4),
>>         DIV_A(none, "armclk", "div_arm", DIV_CPU0, 28, 3, "armclk"),
>>         DIV_F(none, "div_mipi1_pre", "div_mipi1",
>> --
>> 1.7.4.4

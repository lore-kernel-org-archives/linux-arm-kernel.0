From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 17:23:09 +0800
Subject: [linux-sunxi] [PATCH 2/3] pwm: sunxi: Add A64 support
In-Reply-To: <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
References: <20170225074216.64868-1-icenowy@aosc.xyz>
 <20170225074216.64868-2-icenowy@aosc.xyz>
 <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
Message-ID: <870861488014589@web9m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



25.02.2017, 16:53, "Chen-Yu Tsai" <wens@csie.org>:
> On Sat, Feb 25, 2017 at 3:42 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>> ?A64 PWM controller has same register layout as sun4i driver, so it works
>> ?by adding A64 specific data.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ??drivers/pwm/pwm-sun4i.c | 9 +++++++++
>> ??1 file changed, 9 insertions(+)
>>
>> ?diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> ?index 1284ffa05921..ca3431e03fb8 100644
>> ?--- a/drivers/pwm/pwm-sun4i.c
>> ?+++ b/drivers/pwm/pwm-sun4i.c
>> ?@@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
>> ?????????.npwm = 1,
>> ??};
>>
>> ?+static const struct sun4i_pwm_data sun4i_pwm_data_a64 = {
>> ?+ .has_prescaler_bypass = true,
>> ?+ .has_rdy = true,
>> ?+ .npwm = 1,
>> ?+};
>> ?+
>
> This seems to be tha same as the H3. Any differences between the
> H3 and A64? Otherwise please just use that compatible.

H3 is also same as A13...

See http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486595.html

>
> ChenYu
>
>> ??static const struct of_device_id sun4i_pwm_dt_ids[] = {
>> ?????????{
>> ?????????????????.compatible = "allwinner,sun4i-a10-pwm",
>> ?@@ -307,6 +313,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
>> ?????????????????.compatible = "allwinner,sun8i-h3-pwm",
>> ?????????????????.data = &sun4i_pwm_data_h3,
>> ?????????}, {
>> ?+ .compatible = "allwinner,sun50i-a64-pwm",
>> ?+ .data = &sun4i_pwm_data_a64,
>> ?+ }, {
>> ?????????????????/* sentinel */
>> ?????????},
>> ??};
>> ?--
>> ?2.11.1
>>
>> ?--
>> ?You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> ?To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> ?For more options, visit https://groups.google.com/d/optout.

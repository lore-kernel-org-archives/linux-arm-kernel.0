From: weitway@gmail.com (Jason Chen)
Date: Wed, 13 Apr 2011 07:43:23 +0800
Subject: [PATCH] ARM: mx53/loco: add pwm backlight device
In-Reply-To: <20110404160855.GF13963@pengutronix.de>
References: <1299207086-11000-1-git-send-email-b02280@freescale.com>
	<20110404160855.GF13963@pengutronix.de>
Message-ID: <BANLkTi=+1EzK5ZxaAsRRT-e9HzyR3SRUqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Uwe,

Thanks for your comments, I will resend this series patches.

2011/4/5 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Mar 04, 2011 at 10:51:26AM +0800, Jason Chen wrote:
>> Signed-off-by: Jason Chen <b02280@freescale.com>
>> ---
>> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-mx5/board-mx53_loco.c | ? 11 +++++++++++
>> ?arch/arm/mach-mx5/devices-imx53.h ? | ? ?4 ++++
>> ?3 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
>> index f065a0d..baf5223 100644
>> --- a/arch/arm/mach-mx5/Kconfig
>> +++ b/arch/arm/mach-mx5/Kconfig
>> @@ -162,6 +162,7 @@ config MACH_MX53_LOCO
>> ? ? ? select IMX_HAVE_PLATFORM_IMX2_WDT
>> ? ? ? select IMX_HAVE_PLATFORM_IMX_I2C
>> ? ? ? select IMX_HAVE_PLATFORM_IMX_UART
>> + ? ? select IMX_HAVE_PLATFORM_MXC_PWM
>> ? ? ? help
>> ? ? ? ? Include support for MX53 LOCO platform. This includes specific
>> ? ? ? ? configurations for the board and its peripherals.
>> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
>> index 160899e..3b0b200 100644
>> --- a/arch/arm/mach-mx5/board-mx53_loco.c
>> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
>> @@ -23,6 +23,7 @@
>> ?#include <linux/fec.h>
>> ?#include <linux/delay.h>
>> ?#include <linux/gpio.h>
>> +#include <linux/pwm_backlight.h>
>>
>> ?#include <mach/common.h>
>> ?#include <mach/hardware.h>
>> @@ -203,6 +204,13 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>> ? ? ? .bitrate = 100000,
>> ?};
>>
>> +static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
>> + ? ? .pwm_id = 1,
>> + ? ? .max_brightness = 255,
>> + ? ? .dft_brightness = 128,
>> + ? ? .pwm_period_ns = 50000,
>> +};
>> +
>> ?static void __init mx53_loco_board_init(void)
>> ?{
>> ? ? ? mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
>> @@ -213,6 +221,9 @@ static void __init mx53_loco_board_init(void)
>> ? ? ? imx53_add_imx2_wdt(0, NULL);
>> ? ? ? imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
>> ? ? ? imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
>> +
>> + ? ? imx53_add_mxc_pwm(1);
> can you please resend this with the series adding this function when
> addressing the comments I just gave.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

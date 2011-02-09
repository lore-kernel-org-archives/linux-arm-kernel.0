From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 9 Feb 2011 23:07:42 +0800
Subject: [PATCH] ARM: pxa: Properly configure PWM period for palm27x
In-Reply-To: <201102011918.45662.marek.vasut@gmail.com>
References: <1296511613-24406-1-git-send-email-marek.vasut@gmail.com>
	<201102011918.45662.marek.vasut@gmail.com>
Message-ID: <AANLkTi=y76tTMGLokfZqsFRn469Qmbhhd9h9ZfUJ59jS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note: it's eric.y.miao at gmail.com


On Wed, Feb 2, 2011 at 2:18 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Monday 31 January 2011 23:06:53 Marek Vasut wrote:
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

>> ---
>> ?arch/arm/mach-pxa/palm27x.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
>> index 7d1434a..4c9a938 100644
>> --- a/arch/arm/mach-pxa/palm27x.c
>> +++ b/arch/arm/mach-pxa/palm27x.c
>> @@ -322,7 +322,7 @@ static struct platform_pwm_backlight_data
>> palm27x_backlight_data = { .pwm_id ? ? ? ? ? ?= 0,
>> ? ? ? .max_brightness = 0xfe,
>> ? ? ? .dft_brightness = 0x7e,
>> - ? ? .pwm_period_ns ?= 3500,
>> + ? ? .pwm_period_ns ?= 3500 * 1024,
>> ? ? ? .init ? ? ? ? ? = palm27x_backlight_init,
>> ? ? ? .notify ? ? ? ? = palm27x_backlight_notify,
>> ? ? ? .exit ? ? ? ? ? = palm27x_backlight_exit,
>
> CC linux-arm-kernel, I mistyped, sorry
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

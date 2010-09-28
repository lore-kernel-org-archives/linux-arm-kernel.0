From: hemanthv@ti.com (Hemanth V)
Date: Tue, 28 Sep 2010 15:04:43 +0530 (IST)
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.loca
	l>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<201009281114.31223.anarsoul@gmail.com>   
	<F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
	<63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
	<F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <19145.10.24.255.18.1285666483.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >> On 28 of September 2010 10:40:42 Arun Murthy wrote:
>> >> > The existing pwm based led and backlight driver makes use of the
>> >> > pwm(include/linux/pwm.h). So all the board specific pwm drivers
>> will
>> >> > be exposing the same set of function name as in
>> include/linux/pwm.h.
>> >> > As a result build fails.
>> >>
>> >> Which build fails? One with multi-SoC support? Please be more
>> specific.
>> > Sure will add this in v2.
>> >
>>
>> Could you clarify for the benefit of all, which specific issues you are
>> trying to address with this patch series
> 1. Now since all the pwm driver export same set of function(pwm_enable, pwm_disable,..), if it happens that there are two pwm driver enabled this
> leads to re-declaration and results in build failure. The proper way to handle this would be to have a pwm core function, and let all the pwm
> drivers register to the pwm core driver.
> 2. The above scenario also occurs in place of multi-soc environment. Lets say OMAP has a pwm module and that is being used for primary lcd backlight
> and twl has a backlight that is being used for controlling the charging led brightness. In this case there exists 2 pwm drivers and one pwm driver
> will be used by pwm_bl.c and other by leds-pwm.c

Speaking specifically of OMAP4, twl6030 supports multiple PWMs i.e for display/keypad backlight, charging
led. But there should not be need for multiple drivers since twl6030-pwm should be able to support
all these (currently it doesnot though). So there would single pwm_enable, pwm_disable exported and driver
internally takes care configuring the correct PWM based on id. Would it not be similar
situation for other hardware also.

Thanks
Hemanth

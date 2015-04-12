From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 12 Apr 2015 08:41:18 -0700
Subject: [PATCH v3 6/6] hwmon: pwm-fan: Update the duty cycle inorder
 to control the pwm-fan
In-Reply-To: <CANAwSgQ=oorXVsorpvXAjTnLx3zy5pboRBruhirqy6EN_xjEdg@mail.gmail.com>
References: <1428850452-4178-1-git-send-email-linux.amoon@gmail.com>	<1428850452-4178-7-git-send-email-linux.amoon@gmail.com>	<552A8A1C.9000409@roeck-us.net>
 <CANAwSgQ=oorXVsorpvXAjTnLx3zy5pboRBruhirqy6EN_xjEdg@mail.gmail.com>
Message-ID: <552A921E.7050604@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2015 08:29 AM, Anand Moon wrote:
> hi Guenter,
>
> I am referring to #linux/drivers/pwm/pwm-samsung.c
>
> Will update the comment.
>
Sure, but that doesn't help as patch description for the pwm-fan driver.

Guenter

> -Anand Moon
>
> On 12 April 2015 at 20:37, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 04/12/2015 07:54 AM, Anand Moon wrote:
>>>
>>> In order to disable the PWM we need to update using following sequence.
>>>
>>>          pwm_config(pwm, 0, period);
>>>          pwm_disable(pwm);
>>>
>>> pwm_config() with a zero duty cycle to make it clear the timer and update
>>> the PWM registers.
>>> pwm_disable will clear the TCON_AUTORELOAD(tcon_chan) and update the PWM
>>> register.
>>>
>> There is no TCON_AUTORELOAD in this driver. Future developers will have no
>> idea
>> what you are talking about here. Please provide a generic comment.
>>
>>> Next change in state will get trigger unless a new PWM cycle happened.
>>>
>> That sentence is difficult to parse. Actually, I have no idea what it is
>> supposed to mean.
>>
>>>          pwm_config(pwm, duty, period);
>>>          pwm_enable(pwm);
>>>
>>> Through pwm_config we update the duty cycle and period and update the PWM
>>> register.
>>> pwm_enable will update the state to TCON_MANUALUPDATE(tcon_chan)
>>> and TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan) and update the PWM
>>> register.
>>>
>> This sentence does not make sense in the context of the pwm-fan driver.
>>
>>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
>>> Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>    drivers/hwmon/pwm-fan.c | 10 ++++------
>>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>>> index 7c83dc4..f25c841 100644
>>> --- a/drivers/hwmon/pwm-fan.c
>>> +++ b/drivers/hwmon/pwm-fan.c
>>> @@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx,
>>> unsigned long pwm)
>>>          int ret = 0;
>>>
>>>          mutex_lock(&ctx->lock);
>>> +
>>
>>
>> Please refrain from making unnecessary whitespace changes.
>>
>> Thanks,
>> Guenter
>>
>

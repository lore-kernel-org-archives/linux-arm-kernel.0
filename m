From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Jan 2017 11:12:45 -0800
Subject: [PATCH 2/3] pinctrl: meson: meson-gxl: add the pwm_ao_b pin
In-Reply-To: <m2sho91tk5.fsf@baylibre.com>
References: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
 <20170122210528.892-3-martin.blumenstingl@googlemail.com>
 <m2sho91tk5.fsf@baylibre.com>
Message-ID: <CAOi56cV1+2uAMfBe0XQnvwq711fMiXJ+kKRAv9vUO70ZGKhtPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 11:10 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> This adds support for the pwm_ao_b pin. Unfortunately the registers for
>> the pwm_ao pins are not documented at all. The source for the pwm_ao_b
>> pin from this patch is the Khadas VIM GPL kernel source, which sets bit
>> 3 and unsets bits 4 and 31 to enable the PWM LEDs.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/pinctrl/meson/pinctrl-meson-gxl.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
>> index 25694f7094c7..6ff321a7366d 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
>> @@ -222,6 +222,8 @@ static const unsigned int uart_rts_ao_b_pins[]    = { PIN(GPIOAO_3, 0) };
>>
>>  static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
>>
>> +static const unsigned int pwm_ao_b_pins[]    = { PIN(GPIOAO_9, 0) };
>> +
>
> Hmm, the S905 public data sheet[1] shows this as GPIOAO_13.
>

gack, nevermind.  I see now this is for GXL, not GXBB.  Ignore my comments.

Linus, feel free to apply with:

Acked-by: Kevin Hilman <khilman@baylibre.com>

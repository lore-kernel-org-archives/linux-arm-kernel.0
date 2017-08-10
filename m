From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 20:23:17 +0900
Subject: [PATCH 3/3] reset: uniphier: add analog amplifiers reset control
In-Reply-To: <CAK7LNAT_dhx8+_G7yX9OX1yg7cWWpo7vJG5jDwdQe_O9uAe8rw@mail.gmail.com>
References: <20170810072703.32433-1-suzuki.katsuhiro@socionext.com>
 <20170810072703.32433-3-suzuki.katsuhiro@socionext.com>
 <1502361454.10792.5.camel@pengutronix.de>
 <CAK7LNAT_dhx8+_G7yX9OX1yg7cWWpo7vJG5jDwdQe_O9uAe8rw@mail.gmail.com>
Message-ID: <CAK7LNAQ_N-Ji29WvyRVZpqxwezO5Z2ET84ctxE-zmJ386L2AbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


2017-08-10 20:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-08-10 19:37 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> Hi Katsuhiro,
>>
>> On Thu, 2017-08-10 at 16:27 +0900, Katsuhiro Suzuki wrote:
>>> Add a reset line for analog signal amplifier core (ADAMV) on
>>> UniPhier LD11/LD20 SoCs.
>>>
>>> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>>> ---
>>>  drivers/reset/reset-uniphier.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
>>> index f60c137c17cb..cda4a78a58e2 100644
>>> --- a/drivers/reset/reset-uniphier.c
>>> +++ b/drivers/reset/reset-uniphier.c
>>> @@ -196,6 +196,12 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
>>> >     UNIPHIER_RESET_END,
>>>  };
>>>
>>> +/* Analog signal amplifiers reset data */
>>> +static const struct uniphier_reset_data uniphier_ld11_adamv_reset_data[] = {
>>> > +   UNIPHIER_RESETX(100, 0x10, 6), /* EVEA */
>>> > +   UNIPHIER_RESET_END,
>>> +};


I take back my Acked-by.


The reset line index is independent from others
because this block is a separate instance.

Are you OK with starting from the reset ID 100?





-- 
Best Regards
Masahiro Yamada

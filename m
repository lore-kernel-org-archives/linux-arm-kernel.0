From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 20:11:13 +0900
Subject: [PATCH 3/3] reset: uniphier: add analog amplifiers reset control
In-Reply-To: <1502361454.10792.5.camel@pengutronix.de>
References: <20170810072703.32433-1-suzuki.katsuhiro@socionext.com>
 <20170810072703.32433-3-suzuki.katsuhiro@socionext.com>
 <1502361454.10792.5.camel@pengutronix.de>
Message-ID: <CAK7LNAT_dhx8+_G7yX9OX1yg7cWWpo7vJG5jDwdQe_O9uAe8rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-10 19:37 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Katsuhiro,
>
> On Thu, 2017-08-10 at 16:27 +0900, Katsuhiro Suzuki wrote:
>> Add a reset line for analog signal amplifier core (ADAMV) on
>> UniPhier LD11/LD20 SoCs.
>>
>> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>> ---
>>  drivers/reset/reset-uniphier.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
>> index f60c137c17cb..cda4a78a58e2 100644
>> --- a/drivers/reset/reset-uniphier.c
>> +++ b/drivers/reset/reset-uniphier.c
>> @@ -196,6 +196,12 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
>> >     UNIPHIER_RESET_END,
>>  };
>>
>> +/* Analog signal amplifiers reset data */
>> +static const struct uniphier_reset_data uniphier_ld11_adamv_reset_data[] = {
>> > +   UNIPHIER_RESETX(100, 0x10, 6), /* EVEA */
>> > +   UNIPHIER_RESET_END,
>> +};
>> +
>>  /* core implementaton */
>>  struct uniphier_reset_priv {
>> >     struct reset_controller_dev rcdev;
>> @@ -415,6 +421,15 @@ static const struct of_device_id uniphier_reset_match[] = {
>> >             .compatible = "socionext,uniphier-ld20-peri-reset",
>> >             .data = uniphier_pro4_peri_reset_data,
>> >     },
>> > +   /* Analog signal amplifiers reset */
>> > +   {
>> > +           .compatible = "socionext,uniphier-ld11-adamv-reset",
>> > +           .data = uniphier_ld11_adamv_reset_data,
>> > +   },
>> > +   {
>> > +           .compatible = "socionext,uniphier-ld20-adamv-reset",
>> > +           .data = uniphier_ld11_adamv_reset_data,
>> > +   },
>> >     { /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, uniphier_reset_match);
>
> Please add a patch to describe the new compatible values in
> Documentation/devicetree/bindings/reset/uniphier-reset.txt.
>

The code change is OK with me.

Assuming you will update the binding,

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>





-- 
Best Regards
Masahiro Yamada

From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 23 Jul 2015 16:25:10 +0200
Subject: [PATCH v3 2/2] regulator: mt6311: Add support for mt6311 regulator
In-Reply-To: <1437649445.30329.90.camel@mtksdaap41>
References: <1437622799-28115-1-git-send-email-henryc.chen@mediatek.com>
 <1437622799-28115-3-git-send-email-henryc.chen@mediatek.com>
 <CABxcv=kgvCtHxuu0RDbFWEim+HYX74wEYXh8K7a6tT74R5YSuA@mail.gmail.com>
 <1437649445.30329.90.camel@mtksdaap41>
Message-ID: <CABxcv==yOSgQKai0tn9=NGRvKv_3qHgoXUKZT3+M4fK43YWV1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Henry,

On Thu, Jul 23, 2015 at 1:04 PM, Henry Chen <HenryC.Chen@mediatek.com> wrote:
> On Thu, 2015-07-23 at 11:07 +0200, Javier Martinez Canillas wrote:
>
>> > +
>> > +       if (ret < 0)
>> > +               dev_err(&i2c->dev, "Failed to initialize regulator: %d\n", ret);
>> > +
>>
>> I don't think this is necessary, you are already adding logs for all
>> the error conditions.
>
> Yes, I will remove it.
>
>>
>> > +       return ret;
>> > +}
>> > +
>> > +static const struct i2c_device_id mt6311_i2c_id[] = {
>> > +       {"mt6311", 0},
>> > +       {},
>> > +};
>> > +MODULE_DEVICE_TABLE(i2c, mt6311_i2c_id);
>> > +
>> > +#ifdef CONFIG_OF
>> > +static const struct of_device_id mt6311_dt_ids[] = {
>> > +       { .compatible = "mediatek,mt6311-regulator",
>> > +         .data = &mt6311_i2c_id[0] },
>> > +       {},
>> > +};
>> > +MODULE_DEVICE_TABLE(of, mt6311_dt_ids);
>> > +#endif
>> > +
>> > +static struct i2c_driver mt6311_regulator_driver = {
>> > +       .driver = {
>> > +               .name = "mt6311",
>> > +               .owner = THIS_MODULE,
>> > +               .of_match_table = of_match_ptr(mt6311_dt_ids),
>>
>> of_match_ptr() is NULL when CONFIG_OF is not defined so you don't need
>> the additional #ifdef
>> CONFIG_OF around mt6311_dt_ids.
>
> If CONFIG_OF is not defined and without #ifdef CONFIG_OF around
> mt6311_dt_ids, it will allocate a struct mt6311_dt_ids but no one used
> on here, right?
>

You are right, sorry for the noise.

> Henry
>

Best regards,
Javier

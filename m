From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sat, 12 Mar 2016 12:48:02 +0800
Subject: [PATCH v3 01/13] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <CACRpkdZ5o=SKtHxshaedkYNETERt6DfiOPtC5JV2LNWKL_mqDg@mail.gmail.com>
References: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
 <1457192586-25596-2-git-send-email-vishnupatekar0510@gmail.com>
 <CACRpkdZ5o=SKtHxshaedkYNETERt6DfiOPtC5JV2LNWKL_mqDg@mail.gmail.com>
Message-ID: <CAEzqOZta65UBJPBrp_4xr=SzHU98dWDucwzVb80eKE9ChJ8jpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,


On Wed, Mar 9, 2016 at 10:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Mar 5, 2016 at 10:42 PM, Vishnu Patekar
> <vishnupatekar0510@gmail.com> wrote:
>
>> The A83T has R_PIO pin controller, it's same as A23, execpt A83T
>> interrupt bit is 6th and A83T has one extra pin PL12.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> As partly noted by others:
>
>> +config PINCTRL_SUN8I_A83T_R
>> +       def_bool MACH_SUN8I
>
> bool
>
>> +       depends on RESET_CONTROLLER
>
> Should it rather select RESET_CONTROLLER?
I used depends on and def_bool as it is used for other sunxi pinctrl drivers.
Using bool and select will not harm anything.
Should I change it to bool and select ?  or keep it to be uniform with
earlier options?
>
>> +static const struct of_device_id sun8i_a83t_r_pinctrl_match[] = {
>> +       { .compatible = "allwinner,sun8i-a83t-r-pinctrl", },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, sun8i_a83t_r_pinctrl_match);
>
> Module talk in bool driver.
I'll remove it.
>
>> +static struct platform_driver sun8i_a83t_r_pinctrl_driver = {
>> +       .probe  = sun8i_a83t_r_pinctrl_probe,
>> +       .driver = {
>> +               .name           = "sun8i-a83t-r-pinctrl",
>> +               .of_match_table = sun8i_a83t_r_pinctrl_match,
>> +       },
>> +};
>> +module_platform_driver(sun8i_a83t_r_pinctrl_driver);
>
> Should be builtin?
Yes, It should be. I missed Maxime's earlier commets.
>
> Yours,
> Linus Walleij

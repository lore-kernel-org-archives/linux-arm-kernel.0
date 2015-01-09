From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 10 Jan 2015 02:02:39 +0800
Subject: [PATCH 3/3] gpio: sx150x: add dts support for sx150x driver
In-Reply-To: <CACRpkdaeSpvS=k6F-hjyQfGDZdWgckwRjvYwhnQk1NnAhKLJJw@mail.gmail.com>
References: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
 <1417695130-5712-3-git-send-email-21cnbao@gmail.com>
 <CACRpkdaeSpvS=k6F-hjyQfGDZdWgckwRjvYwhnQk1NnAhKLJJw@mail.gmail.com>
Message-ID: <CAGsJ_4xrTt1+6E-VhGb7PMY_6PHVK-e1nhip1SUHmWJcL4fQGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-09 18:02 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Dec 4, 2014 at 1:12 PM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Wei Chen <Wei.Chen@csr.com>
>>
>> Current sx150x gpio expander driver doesn't support DT. Now we added DT support
>> for this driver.
>>
>> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> (...)
>> +-pullup_ena:A bit-mask which enables or disables the pull-up resistor
>> +       for each IO line in the expander. = <0x0>;
>> +
>> +-pulldn_ena:A bit-mask which enables-or disables the pull-down resistor
>> +       for each IO line in the expander.
>> +
>> +-open_drain_ena:A bit-mask which enables-or disables open-drain
>> +       operation for each IO line in the expander.
>> +
>> +-polarity: A bit-mask which enables polarity inversion for each IO line
>> +       in the expander.
>
> I don't particularly like these properties.
>
> This is basically pin control stuff.
>
> I know that the driver was merged way before the pin control subsystem
> existed and before I was maintainer of GPIO. So it has some tradition
> behind it.
>
> Still I would *really* prefer that it was at least described the way
> pin controllers usually are, so we have the option of converting it
> to pin control later.
>
> The major difference if you check the pin control standard bindings,
> is that instead of hammering down the config of different lines in
> the controller, the config is tied to the consumers, as these are
> the devices actually requiring that config.
>
> I.e. it's not a property of the *controller* that a line is pulled down,
> that is a property of whatever is connected to that line.
>
> Maybe I'm overzealous so that this would require implenenting
> a whole lot of pin control stuff and move the driver to drivers/pinctrl,
> but I won't let it go without a discussion first.

my suggestion is we split this patch into two, the first one adds the
basic gpio dt support, then we consider the pin configuration issue.

>
> Yours,
> Linus Walleij
-barry

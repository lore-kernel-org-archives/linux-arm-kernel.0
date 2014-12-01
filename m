From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 1 Dec 2014 20:18:10 +0530
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <5607434.rlEIdu4yyh@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
 <7885354.QleDlR7NUO@wuerfel>
 <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
 <5607434.rlEIdu4yyh@wuerfel>
Message-ID: <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2014 at 19:35, Arnd Bergmann <arnd@arndb.de> wrote:
> I guess a string would be better here, the idea here was to
> have a different bool property per driver, which would also
> work.

Hmm, I will prefer string as we don't need to define any more bindings then
for new drivers.

>> > @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>> >         if (!IS_ERR(cpu_reg))
>> >                 regulator_put(cpu_reg);
>> >
>> > -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
>> > -
>>
>> We still need this, and its about how clocks are shared between CPUs.
>
> I didn't see where this comes from. Who is setting up this platform
> data?

Mvebu is using it to communicate that all CPUs have separate
clock lines.

--
viresh

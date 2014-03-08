From: carlo@caione.org (Carlo Caione)
Date: Sat, 8 Mar 2014 12:43:04 +0100
Subject: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
In-Reply-To: <20140307182213.GC607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140307182213.GC607@lukather>
Message-ID: <CAOQ7t2YSidSPVSBrBzj3R1SYS_Xb10a2vfEs+u1DEkrhEJQCaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 7:22 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
>> +static struct platform_driver axp20x_regulator_driver = {
>> +     .probe  = axp20x_regulator_probe,
>> +     .remove = axp20x_regulator_remove,
>> +     .driver = {
>> +             .name           = "axp20x-regulator",
>> +             .owner          = THIS_MODULE,
>> +     },
>> +};
>> +
>> +static int __init axp20x_regulator_init(void)
>> +{
>> +     return platform_driver_register(&axp20x_regulator_driver);
>> +}
>> +
>> +subsys_initcall(axp20x_regulator_init);
>
> Hmmm, really?
>
> I thought the AXP was only connected through I2C? How is that a
> platform device then?

Not really. It is plain wrong.
I'll fix it in v2.

Thanks,

-- 
Carlo Caione

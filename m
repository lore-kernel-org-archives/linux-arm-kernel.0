From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 Aug 2016 15:35:09 +0200
Subject: [PATCH 1/3] clk: meson: Add GXBB AO Clock and Reset controller
 driver
In-Reply-To: <CAP=VYLphcuq16vDueOOJ6anrW-ifYAK+1ijSjkGbxw48+m4xrw@mail.gmail.com>
References: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
 <1470734008-18849-2-git-send-email-narmstrong@baylibre.com>
 <CAP=VYLphcuq16vDueOOJ6anrW-ifYAK+1ijSjkGbxw48+m4xrw@mail.gmail.com>
Message-ID: <5529118a-63f0-cb54-f6a4-305603da168f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2016 02:08 AM, Paul Gortmaker wrote:
> On Tue, Aug 9, 2016 at 5:13 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Adds a Clock and Reset controller driver for the Always-On part
>> of the Amlogic Meson GXBB SoC.
>>
>> It exports paired Clocks and Resets lines that will be used by
>> peripherals in the Always-On subsystem.
> 
> [...]
> 
>> +static const struct of_device_id gxbb_aoclkc_match_table[] = {
>> +       { .compatible = "amlogic,gxbb-aoclkc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, gxbb_aoclkc_match_table);
>> +
>> +static struct platform_driver gxbb_aoclkc_driver = {
>> +       .probe          = gxbb_aoclkc_probe,
>> +       .driver         = {
>> +               .name   = "gxbb-aoclkc",
>> +               .of_match_table = gxbb_aoclkc_match_table,
>> +       },
>> +};
>> +
>> +module_platform_driver(gxbb_aoclkc_driver);
>> +
>> +MODULE_DESCRIPTION("AmLogic Meson GXBB AO Clock Controller Driver");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> +MODULE_ALIAS("platform:gxbb-aoclkc");
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> 
> Since this driver is controlled by a bool Kconfig, you can dump the module.h
> include and all the MODULE_<xyz> tags above.
> 
> Or, if there is a genuine use case for it to be modular, then make it tristate?
> 
> Thanks,
> Paul.
> 

It will be non-modular.

Thanks,
Neil

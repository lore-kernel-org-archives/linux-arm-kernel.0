From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:54:56 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <201204131451.10638.arnd@arndb.de>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <1334328122.27644.15.camel@hornet> <201204131451.10638.arnd@arndb.de>
Message-ID: <4F883E40.6000905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/12 15:51, Arnd Bergmann wrote:
> On Friday 13 April 2012, Pawel Moll wrote:
>> On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
>>> +     of_property_read_u32(np, "wp-gpios",&pdata->gpio_wp);
>>> +     if (!pdata->gpio_wp)
>>> +             pdata->gpio_wp = -1;
>>> +
>>> +     of_property_read_u32(np, "cd-gpios",&pdata->gpio_cd);
>>> +     if (!pdata->gpio_cd)
>>> +             pdata->gpio_cd = -1;
>>
>> I think you should use of_gpio_named_count(np, "XX-gpios") here rather
>> then of_property_read() - there's more to GPIOs than just a number...
>
> Hmm, that part was done right in the git tree, I guess something
> went wrong when sending out the series.

Different patch series.

The GPIO bindings aren't in yet. Once this one is accepted, I'll fire 
off the second patch-set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

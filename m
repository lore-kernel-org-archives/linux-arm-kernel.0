From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 25 Apr 2018 11:26:46 +0200
Subject: [RESEND PATCH v2 4/4] ARM: davinci: use aemif platform driver in
 legacy mode for da850-evm
In-Reply-To: <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-5-brgl@bgdev.pl>
 <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
Message-ID: <CAMRc=Mes-JfzRw2ukdQ21S86HA_iH4fu8cjq0OmJOsO5DPirYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-17 16:12 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We now support board files in aemif. Use the platform driver instead
>> of the handcrafted API in da850-evm.
>>
>> Note: the id of davinci_nand is changed to 0 in order to make it work
>> with the new common-clock framework based psc driver.
>
> Is this now needed after applying my patch dropping clock acquisition
> from DaVinci NAND driver?
>

Now that I realized that pdev->id matters for the driver as well, I'm
thinking this may have broken the support. Unfortunately we don't have
the nand extension for da850-evm to test it. I'll revert it to the
previous value.

Bart

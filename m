From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 16 Mar 2018 16:19:43 +0000
Subject: [PATCH v5 0/2] add support for Socionext SynQuacer I2C controller
In-Reply-To: <CAKv+Gu_hRsJGT-inrzXmAmabaZiUTL7BowdUrxwSWHJecjeVsg@mail.gmail.com>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu_hRsJGT-inrzXmAmabaZiUTL7BowdUrxwSWHJecjeVsg@mail.gmail.com>
Message-ID: <CAKv+Gu-7MP9OqsQpR+AKzn=yHTH5qv5pa4THy0X5JGr-O+XLDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2018 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 2 March 2018 at 08:31, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
>> SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.
>>
>> I think this is good to go now. Wolfram?
>>
>
> Ping?
>

Ping?

>> v5:
>> - add Rob's ack to #1
>> - drop unnecessary 'platform_set_drvdata(pdev, NULL)' in remove path (#2)
>>
>> v4:
>> - clarify binding that only a single interrupt specifier is expected (#1)
>> - check return value of clk_prepare_enable() on probe path (#2)
>> - add Andy's R-b to patch #2
>>
>> v3:
>> - incorporate more of Andy's review comments (#2), especially regarding the
>>   bus speed and clock source handling for ACPI
>> - patch #1 unchanged.
>>
>> v2:
>> - incorporate Andy's review comments (#2)
>> - patch #1 unchanged.
>>
>> Ard Biesheuvel (2):
>>   dt-bindings: i2c: add binding for Socionext SynQuacer I2C
>>   i2c: add support for Socionext SynQuacer I2C controller
>>
>>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
>>  drivers/i2c/busses/Kconfig                              |  10 +
>>  drivers/i2c/busses/Makefile                             |   1 +
>>  drivers/i2c/busses/i2c-synquacer.c                      | 791 ++++++++++++++++++++
>>  4 files changed, 831 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>>  create mode 100644 drivers/i2c/busses/i2c-synquacer.c
>>
>> --
>> 2.11.0
>>

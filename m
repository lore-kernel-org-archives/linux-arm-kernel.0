From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 4 Jul 2012 20:15:51 +0800
Subject: [PATCH 1/2] ARM: PRIMA2: add of_dev_auxdata table for I2C, SPI,
 UART and PINCTRL
In-Reply-To: <201207041143.04942.arnd@arndb.de>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
 <201207041143.04942.arnd@arndb.de>
Message-ID: <CAGsJ_4zU8p8sVweoUWbuggLfetUuD1Ooem=Ku5i1t9p8CX0hgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2012/7/4 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 04 July 2012, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> This patch adds lookup table for attaching a specific name and platform_data
>> pointer to devices like i2c, spi, uart and pinctrl as they get created by
>> of_platform_populate().  Ideally this table would not exist.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Hi Barry,
>
> I don't understand. Which subsystem relies on the short names here?
>
> If it's about the pinctrl and clock parts, can't you just uses the
> generate names like "b0050000.uart" directly?

yes. names like "b0050000.uart"  really work, and i have enabled and
tested names like that in clock driver.
but would people think them ugly?

and what would the clock driver support two SoCs whose uarts have
different map base address?

>
>         Arnd

-barry

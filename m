From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Feb 2012 10:20:36 +0800
Subject: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
 <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
Message-ID: <CAGsJ_4zNjkLOs_A8H1-yteDTZodFGjh=3k9x0P-hmBb1w2q4vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>>> index 3101dd5..a3c43fc 100644
>>> --- a/drivers/i2c/busses/Kconfig
>>> +++ b/drivers/i2c/busses/Kconfig
>>> @@ -618,6 +618,16 @@ config I2C_SH_MOBILE
>>> ? ? ? ? This driver can also be built as a module. ?If so, the module
>>> ? ? ? ? will be called i2c-sh_mobile.
>>>
>>> +config I2C_SIRF
>>> + ? ? tristate "CSR SiRFprimaII I2C interface"
>>> + ? ? depends on ARCH_PRIMA2
>>> + ? ? help
>>> + ? ? ? If you say yes to this option, support will be included for the
>>> + ? ? ? CSR SiRFprimaII I2C interface.
>>> +
>>> + ? ? ? This driver can also be built as a module. ?If so, the module
>>> + ? ? ? will be called i2c-sirf.
>>> +
>>
>> Sorting is broken, same with Makefile.
>
> sorry. i don't get this. I2C_SIRF have be placed in "I2C system bus
> drivers (mostly embedded / system-on-chip)" submenu and placed between
> "I2C_SH_MOBILE" and "I2C_SIMTEC".
> what is the problem?
>

Oh.... i was making some stupid mistake. i thought R is earlier than
M. in fact,  it is L->M->N->O->P->Q->R, so move I2C_SIRF behind
"I2C_SIMTEC".
-barry

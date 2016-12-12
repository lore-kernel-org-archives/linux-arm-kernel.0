From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 12 Dec 2016 09:34:29 +0100
Subject: [PATCH v5 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20161211214232.GA2552@katana>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-3-git-send-email-cedric.madianga@gmail.com>
 <20161211214232.GA2552@katana>
Message-ID: <CAOAejn0gH3t8NGLUELfB3nv-UM=Gtr04JtLqrm=SiYfPVbYv-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for your comments.
I will fix all of them + build errors reported by build-bot in the V6.

Best regards,

Cedric Madianga

2016-12-11 22:42 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi,
>
>> +config I2C_STM32F4
>> +     tristate "STMicroelectronics STM32F4 I2C support"
>> +     depends on ARCH_STM32  || COMPILE_TEST
>
> Double space.
>
>> +#define STM32F4_I2C_MIN_FREQ         2
>> +#define STM32F4_I2C_MAX_FREQ         42
>
> Those two must be unsigned to fix the build error (e.g. 2U) reported by
> build-bot.
>
> Also, I get the following build warnings:
>
>   CC      drivers/i2c/busses/i2c-stm32f4.o
> drivers/i2c/busses/i2c-stm32f4.c: In function ?stm32f4_i2c_handle_rx_addr?:
> drivers/i2c/busses/i2c-stm32f4.c:445:6: warning: variable ?sr2? set but not used [-Wunused-but-set-variable]
>   u32 sr2;
>       ^~~
> drivers/i2c/busses/i2c-stm32f4.c: In function ?stm32f4_i2c_isr_event?:
> drivers/i2c/busses/i2c-stm32f4.c:496:41: warning: variable ?sr2? set but not used [-Wunused-but-set-variable]
>   u32 real_status, possible_status, ien, sr2;
>
> I assume those are reads to clear the register, so we really don't need
> to save the value in a variable.
>
> Rest is looking good.
>
> Thanks,
>
>    Wolfram
>

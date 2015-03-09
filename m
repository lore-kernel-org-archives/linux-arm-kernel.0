From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 9 Mar 2015 17:51:40 +0100
Subject: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CACRpkdaW-OMgGfw8+ngia8AsmzRpW8z7922=dPpRGjgv79-gqw@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdaW-OMgGfw8+ngia8AsmzRpW8z7922=dPpRGjgv79-gqw@mail.gmail.com>
Message-ID: <CALszF6DW4_2AmVgG3EBNqKTaP=cf-ZimZCR7_Cynqz5Uczs2+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-09 15:39 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>
>> The STMicrolectornics's STM32F419 MCU has the following main features:
>>  - Cortex-M4 core running up to @180MHz
>>  - 2MB internal flash, 256KBytes internal RAM
>>  - FMC controller to connect SDRAM, NOR and NAND memories
>>  - SD/MMC/SDIO support
>>  - Ethernet controller
>>  - USB OTFG FS & HS controllers
>>  - I2C, SPI, CAN busses support
>>  - Several 16 & 32 bits general purpose timers
>>  - Serial Audio interface
>>  - LCD controller
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> (...)
>> +       soc {
>> +               usart1: usart at 40011000 {
>> +                       status = "okay";
>> +               };
>> +
>> +               leds {
>> +                       compatible = "gpio-leds";
>> +                       red {
>> +                               #gpio-cells = <2>;
>> +                               label = "Front Panel LED";
>> +                               gpios = <&gpiog 14 0>;
>> +                               linux,default-trigger = "heartbeat";
>> +                       };
>> +                       green {
>> +                               #gpio-cells = <2>;
>> +                               gpios = <&gpiog 13 0>;
>> +                               default-state = "off";
>> +                       };
>> +               };
>> +       };
>
> The LEDs are mounted on the board not the SoC, right?
>
> So move them outside of the soc node, to the top level
> of the DTS file.

Yes, you are right.
Andreas already made the same remark, and the top-level move is
already here in the upcoming v3.

Thanks,
Maxime
>
> Yours,
> Linus Walleij

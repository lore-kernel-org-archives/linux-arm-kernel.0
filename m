From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 May 2012 21:04:22 +0800
Subject: CSR SiRFSoC PRIMA2: SPI compilation broken in 3.4-rc7
In-Reply-To: <CACRpkdb17CAYazMO86KL1=EgKJ0zbE0RDb_fPnLZ5sKW70Vi2A@mail.gmail.com>
References: <Pine.LNX.4.64.1205141311060.4916@axis700.grange>
 <CACRpkdb17CAYazMO86KL1=EgKJ0zbE0RDb_fPnLZ5sKW70Vi2A@mail.gmail.com>
Message-ID: <CAGsJ_4wupgPZbEdA0dXmbBikON6bFDYHn3U1KnYB_w1PbSE22Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus/Guennadi,

2012/5/14 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, May 14, 2012 at 1:14 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
>
>> Might be good to try to fix for 3.4 release:
>>
>> drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
>> drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
>> drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
>> drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
>> drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
>> drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
>> make[3]: *** [drivers/spi/spi-sirf.o] Error 1
>
> How are you producing this?
>
> config SPI_SIRF
> ? ? ? ?tristate "CSR SiRFprimaII SPI controller"
> ? ? ? ?depends on ARCH_PRIMA2
>
> So must be on ARCH_PRIMA2, but:
>
> grep -r PRIMA2 arch/arm/configs/
>
> So no defconfig can be used to compile this.
>
> If I could just reproduce it, I could fix it...
>
> Barry pls submit a defconfig for the PRIMA2 so we can
> compile it and test for regressions.

i will send two patches to fix that. one is for pinmux api changes,
the other one is defconfig of primaii.

>
> Yours,
> Linus Walleij
>

Thanks
barry

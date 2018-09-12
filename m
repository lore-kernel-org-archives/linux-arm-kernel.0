From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Sep 2018 09:41:43 +0100
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
In-Reply-To: <20180912073355.GB2557@piout.net>
References: <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell> <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
Message-ID: <20180912084143.GN4185@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > 
> > > > USART doc starting p572, registers p621.
> > 
> > After looking at the datasheet, I don't see any reason why one of the
> > two drivers can't be selected using different compatible strings.
> 
> Because there is only one IP and we don't use the device tree to selecet
> linux specific drivers.

We do it all the time.  There are loads of MFDs (def: same IP, with
different functions) which have separate compatibles for their various
functions.  If you wish this IP to operate as an SPI controller, it
should have an SPI compatible, if you wish it to operate as a U(S)ART,
then it should have a UART compatible.  It's what we do for most of
the other MFDs in the kernel.

> If you are not happy having that in MFD, I guess we can move it out
> somewhere else.

My issue isn't pertaining to where the hack lives, it's that there is
a hack in the first place.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 17 Dec 2014 21:16:22 +0100
Subject: at91: dt: dma usage
In-Reply-To: <54477097.1050909@aksignal.cz>
References: <e2dd545ccf0051e1089b1a313205547c44df5c12.1413190828.git.jiri.prchal@aksignal.cz>
 <20141014122423.GA2797@ldesroches-Latitude-E6320>
 <54468C1B.9070500@atmel.com> <54477097.1050909@aksignal.cz>
Message-ID: <20141217201622.GE4885@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/10/2014 at 10:53:43 +0200, Ji?? Prchal wrote :
> in fact that in at91sam chips has a lot of peripherals but only 2*8 dma channels
> and as my patch in last week "at91: sam9x5 dt: add usart dma definitions to dt"
> adds only dma definitions, not make to use them, leave it on board definition,
> shouldn't do the same all other peripherals definitions?
> I think that I2C, SPI are not as necessary as USART, but thous are always "on".

Not much discussion happened on that and I have the feeling this is
something we have to sort out. Until the dma driver are able to allocate
channels dynamically, it is true that this may be something we shouldn't
enable in the dtsi and let people activate dma in the board dts.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

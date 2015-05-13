From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 21:11:33 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
Message-ID: <13641152.Yt4ZI3oT6L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 18:54:10 Maxime Coquelin wrote:
> This calculation is true, but we have to take into account there is a
> hole in the middle, between AHB3, and APB1 register:
> 
> AHB1RSTR : offset = 0x10, index = 0
> AHB2RSTR : offset = 0x14, index = 1
> AHB3RSTR : offset = 0x18, index = 2
> <HOLE >     : offset = 0x1c, index = 3
> APB1RSTR : offset = 0x20, index = 4
> APB2RSTR : offset = 0x24, index = 5
> 
> So we have to carefully document this hole in the bindings, maybe by
> listing indexes in the documentation?

I would only list the index definitions in the binding if they
are common across all chips using that binding.

>From what I see above, this is really regular, so it's possible
that others follow it as well, but it's also possible that another
chip completely screwed up that system because it didn't fit
otherwise.

Ideally the binding should follow closely what is documented
in the data sheet.

> > Are there parts that need something else? If the 0x10 offset is
> > different, we probably want a different compatible string, and I'd
> > consider it a different part at that point. If there are chips
> > that do not spread the clock from the reset by exactly 256 bits,
> > we could add a DT property in the rcc node for that.
> 
> I will check other chips, to see if this is valid generally.

Ok.

	Arnd

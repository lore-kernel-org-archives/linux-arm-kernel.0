From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Aug 2014 01:05:24 +0800
Subject: [PATCH] ARM: at91: spi: request all csgpio in spi probe
In-Reply-To: <20140731164836.GI3214@piout.net>
References: <b033d16ec31d26a895726ee72ec89b43943dfbae.1406547656.git.jiri.prchal@aksignal.cz>
 <20140728122103.GR9532@piout.net> <53D64ADA.1000102@aksignal.cz>
 <20140728223859.GA3214@piout.net> <20140729100017.31f0b1be@bbrezillon>
 <20140731155906.GH3214@piout.net>
 <C5B462AE-B1D2-4067-91EB-44FDF49D28FA@jcrosoft.com>
 <20140731164836.GI3214@piout.net>
Message-ID: <1EB953D9-8221-47A0-9025-0C39DD09B631@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 1, 2014, at 12:48 AM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> 
> On 01/08/2014 at 00:10:05 +0800, Jean-Christophe PLAGNIOL-VILLARD wrote :
>>>>> While this solves the particular issue Ji?? is seeing, this will not
>>>>> solve the case where PA14 (CS0) is not used by the spi driver at all. It
>>>>> will remained muxed as CS0 and toggle when the spi master needs to
>>>>> access CS0 until another driver muxes it to something else. I still
>>>>> believe we should explicitly ask pinctrl to mux them as gpios.
>> 
>> This is not the job of the kernel but to the bootloader
>> no the pinctrl binding is not here and will never be here the configure a pin as a GPIO or
> 
> This is exactly what AT91_PERIPH_GPIO does though. Anyway, not request
> the pinmuxing in the driver is not a good idea, then nothing prevents
> another driver to request them to do something completely different.

here it?s the same issue if you need to pin as GPIO use the GPIO API not the pinctrl

AT91_PERIPH_GPIO is use the set specific pinmux (bouncing & etc?)


> 
>> to a specific state. This the job of the driver or the bootloader
>> 
> 
> I agree that it must not allow to set the state, we are talking about
> muxing.
> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

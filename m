From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 16:17:51 +0200
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <20111010114407.GD3607@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
	<20111010114407.GD3607@opensource.wolfsonmicro.com>
Message-ID: <201110111617.52061.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 October 2011, Mark Brown wrote:
> On Mon, Oct 10, 2011 at 01:42:30PM +0200, Zoltan Devai wrote:
> 
> > Where should the adc driver go in this case ?
> 
> At the minute it seems to me that arch/arm is as good a place as any
> really - currently this code is getting dumped wherever the main device
> is.

My feeling is that there is a general class of drivers involving
the gpio, pinmux, pwm, led, adc and dac: these are basically all
things you do with a single pin. Right now we have subsystems for
some of them, adding some others and don't have anything for adc
basides iio (which only partially fits here).

Since there is no externally visible interface for this kind of
adc driver, we can always fix it later, which helps a lot. How
about putting it into drivers/adc or drivers/misc/adc for now
and waiting for others to join it? We can then later make it a
proper subsystem along the lines of gpio and pwm and move
interfaces for input, hwmon and iio into the subsystem.

	Arnd

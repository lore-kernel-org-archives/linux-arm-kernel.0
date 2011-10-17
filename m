From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Oct 2011 17:11:36 +0200
Subject: pinctrl_config APIs, and other pinmux questions
In-Reply-To: <20111014145900.GA28728@S2100-06.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A166@HQMAIL01.nvidia.com>
	<20111014145900.GA28728@S2100-06.ap.freescale.net>
Message-ID: <CACRpkdZ7QZJ5YwDYKHKmCz7ssPr9Au8mVk4P3R1RMbbOpe9XNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 4:59 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> [Stephen]
>> I've started to look at porting the Tegra pinmux driver to your pinctrl
>> subsystem. In order to replace the existing pinmux driver, I need a way
>> to support configuring options such as tri-state, pull-up/down, drive-
>> strength, etc.
>>
> I'm also concerned about this. ?The current pinctrl subsystem only
> implements pinmux. ?Before pin/pad configuration (pincfg) support is
> available, I can not really convert imx iomuxc driver (iomux-v3) over
> to use the subsystem.

I have the same problem for drivers/gpio/gpio-nomadik. which
does all weird kind of stuff. So you're not alone.

The reason why this is not in the subsystem as of today is that
we cannot push hundreds of kilobytes of upfront design with no drivers
using it, the current patch set in for-next is big enough as it is right
now.
http://en.wikipedia.org/wiki/Big_Design_Up_Front

But we can start thinking about the next step, so lets design the
generic pin control stuff we need and merge it to -next early so
we can work on it next kernel cycle.

Yours,
Linus Walleij

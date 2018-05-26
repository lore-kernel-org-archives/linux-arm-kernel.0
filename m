From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 26 May 2018 18:38:43 +0200
Subject: i2c-gpio and boards conversions to GPIO descriptors
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
Message-ID: <CACRpkdb26T7JNHOPSFxmPLyNnMDqpNYnMZxKEHGL8gPo9V2Sjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 5:41 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> Hi Linus,
>
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
>
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.

Yeah what a mess, I'm sending patches to fix it up, the ARM
patch already sent, I will send a separate one for the MIPS
machines.

Sorry for the mess! :(

Yours,
Linus Walleij

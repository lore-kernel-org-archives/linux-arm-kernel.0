From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 09:03:52 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120517104249.GI9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120516111744.GB9571@n2100.arm.linux.org.uk>
 <CACRpkdazMG1D6L6nWo330EWTZ_Fn6K0F5cjZSfMRGmk9OsaVXw@mail.gmail.com>
 <20120517104249.GI9571@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYgGgY7PTW3oVM-kXrGHYVsbP8sE3cihpttmZkDc00TdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 12:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> On Wed, May 16, 2012 at 01:59:42PM +0200, Linus Walleij wrote:
>> Maybe just rename this thing cctl_memcpy then?
>
> I've just noticed that arm-soc contains this (eg):
>
> struct pl08x_channel_data spear310_dma_info[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.bus_id = "uart0_rx",
> ? ? ? ? ? ? ? ?.min_signal = 2,
> ? ? ? ? ? ? ? ?.max_signal = 2,
> ? ? ? ? ? ? ? ?.muxval = 0,
> ? ? ? ? ? ? ? ?.cctl = 0,
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ? ? ? ? ? ? ? ?.periph_buses = PL08X_AHB1,
>
> So, changing .cctl to .cctl_memcpy breaks the compilation for all the spear
> platforms. ?Moreover, these explicit-zero initializers should not be here.
> Even with these gone, one still remains in the spear6xx code for their
> memcpy support.
>
> Can we get these zero initializers killed for this merge window please.

That'd be Viresh's patch set I think ... Viresh can you post a patch on
top of the stuff in ARM SoC that kills off the zero intializers for cctl?

Yours,
Linus Walleij

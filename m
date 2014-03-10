From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Mar 2014 20:16:25 +0100
Subject: [PATCH v6 6/6] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <1469359.kil5iaOqdU@wuerfel>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <2115856.ZTdgp5fkma@wuerfel>
 <20140310163343.GY6457@e106497-lin.cambridge.arm.com>
 <1469359.kil5iaOqdU@wuerfel>
Message-ID: <CAMuHMdWzm1D83zquwuQVKwbqRdXmSw7u1ui7iZyC3VGdGhn0HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 7:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> arch/avr32/include/asm/io.h:#define IO_SPACE_LIMIT    0xffffffff
>> arch/frv/include/asm/io.h:#define IO_SPACE_LIMIT      0xffffffff
>
> They have no MMU, and the code relies on the port number to match
> both the virtual and the physical address. You could be right about
> these, but I would guess that the code also needs some other
> changes if we want to make it work on nommu kernels. It also depends
> on whether the I/O bus address is the same as the CPU address, or
> if it starts at bus address 0.

>> arch/m68k/include/asm/io_no.h:#define IO_SPACE_LIMIT 0xffffffff
>
> This looks like a mistake, it should be smaller

io_no.h is for nommu.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

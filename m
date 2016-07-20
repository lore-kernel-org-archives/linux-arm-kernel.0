From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Jul 2016 11:43:03 +0200
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Tue, Jul 12, 2016 at 9:46 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> Clocks described by this property are reserved for use by Xen, and the OS
> must not alter their state any way, such as disabling or gating a clock,
> or modifying its rate. Ensuring this may impose constraints on parent
> clocks or other resources used by the clock tree.
>
> This property is used to proxy clocks for devices Xen has taken ownership
> of, such as UARTs, for which the associated clock controller(s) remain
> under the control of Dom0.

I'm not familiar with using XEN at all, but I'm a bit puzzled...

Can't you just add a clocks property to the (virtual) serial device node in DT?
Then the (virtual) serial device driver can get and enable the clock?

Alternatively, you can add a (virtual) clock controller, and power-domains
and clock properties to all affected devices (I assume there can be others,
besides virtual UARTs?), and let it be handled by Runtime PM, without the
(virtual) device drivers having to care about clocks at all.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

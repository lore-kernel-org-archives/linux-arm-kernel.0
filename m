From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Feb 2015 15:43:43 +0100
Subject: [PATCH v2 2/5] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <7800327.b3sMA1XGtZ@wuerfel>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
 <1423059315-28519-3-git-send-email-geert+renesas@glider.be>
 <7800327.b3sMA1XGtZ@wuerfel>
Message-ID: <CAMuHMdVi3kq2p30cNFYW2WCM-OvMSFC1W0r5nYkaN5Np=zW4_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Feb 4, 2015 at 3:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 04 February 2015 15:15:12 Geert Uytterhoeven wrote:
>>  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
>> +       .l2c_aux_val    = L2C_AUX_CTRL_SHARED_OVERRIDE,
>> +       .l2c_aux_mask   = ~L2C_AUX_CTRL_SHARED_OVERRIDE,
>>         .map_io         = r8a7740_map_io,
>>         .init_early     = shmobile_init_delay,
>>         .init_irq       = r8a7740_init_irq_of,
>
> +Russell
>
> I'd hope we could avoid having any overrides in here that are not
> specified in DT. I can never remember what we discussed about particular
> bits in the past though. Is this bit something we could add a binding
> for, or could we make it enabled by default?
>
> I assume you have to add it because the boot loader sets the wrong
> default, right?

Indeed. Note that I only try to preserve the register value before and after
migrating to generic l2c OF initialization. I did read (part of) the pl310
documentation, but it's still not clear to me if we really need
L2C_AUX_CTRL_SHARED_OVERRIDE. Perhaps this was just copied from
somewhere else without much afterthought?

The previous version was in thread
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318328.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

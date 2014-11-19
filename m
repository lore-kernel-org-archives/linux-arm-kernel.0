From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Nov 2014 14:17:10 +0100
Subject: [PATCH 1/2] ARM: imx: Remove unneeded .map_io initialization
In-Reply-To: <20141114160205.GH4042@n2100.arm.linux.org.uk>
References: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
 <20141114160205.GH4042@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdXM_Td8Pz3zTvMXPTJSAzZ0mjDuq4n2cG7fuUO2Wzj65A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 5:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 14, 2014 at 04:53:57PM +0100, Geert Uytterhoeven wrote:
>> If machine_desc.map_io is not set, devicemaps_init() in the common ARM
>> code will call debug_ll_io_init().
>
> How about a WARN_ON(mdesc->map_io == debug_ll_io_init) ?  This can only
> really be done when CONFIG_DEBUG_LL is defined because otherwise it's an
> inline function, but it may help to stop these from appearing in the
> first place.

I'd rather have a BUILD_BUG_ON(). Unfortunately MACHINE_END doesn't
know about the machine type, else we could probably add a check to that
macro.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

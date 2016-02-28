From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 28 Feb 2016 09:55:32 +0100
Subject: [PATCH/RFC v2 00/11] ARM/arm64: renesas: Add SYSC PM Domain DT
 Support
In-Reply-To: <8723964.uvbBYGm8Wz@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <8723964.uvbBYGm8Wz@avalon>
Message-ID: <CAMuHMdWxHWfghHM5xLVPdDcun5bQPVJKBQ69ZAa6TszDFD+XBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Sat, Feb 27, 2016 at 2:53 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> After rebasing this series on top of Simon's latest devel branch, I'm
> experiencing hard system freezes when using the VSP.

Is this due to the rebasing? Did it work in renesas-drivers-2016-02-16-v4.5-rc4
or renesas-drivers-2016-02-23-v4.5-rc5?

> What makes the problem curious is that PM runtime works fine when the VSP
> instances are probed, the A3VP power domain is turned on and off correctly for
> each instance. However, after booting the system, if I try to RPM resume the
> device, the system hangs.
>
> I've traced this (using printk debugging) down to the SYSCISCR write in
> rcar_sysc_power(). The value written is 0x00000200, which corresponds to the
> A3VP power domain, and the resume request completion wait loop doesn't time
> out.

So the second write to SYSCISCR in that function locks up the system?

> Does this ring any bell ? Do you have a more recent version of this patch
> series that I could try ?

No clue, and no more recent version available yet.

What do I need to reproduce this?

Thanks for testing!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

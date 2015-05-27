From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 27 May 2015 11:07:15 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Make USB support modular
In-Reply-To: <11285144.SLyHNBFeg0@avalon>
References: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
 <1432637918-8946-2-git-send-email-geert+renesas@glider.be>
 <11285144.SLyHNBFeg0@avalon>
Message-ID: <CAMuHMdUFMLGHAYT06s6Twt+1jvhAHyCk2p0xv6xntiVjffvdug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, May 26, 2015 at 2:26 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 26 May 2015 12:58:38 Geert Uytterhoeven wrote:
>> Make USB support modular to reduce kernel size:
>
> This means we lose support for NFS root on USB-based ethernet controllers. I'm
> not sure that's a very good idea.

That's true...

Enabling the USB network drivers is one thing I can easily do myself.
But I don't know on which boards they are used, and which USB host
controller drivers are needed.

P.S. Strange, USB_NET_DRIVERS is tristate, but setting it to "y" doesn't
     mean all USB network drivers become builtin, as USB_NET_DRIVERS is never
     used in a "depends" construct...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

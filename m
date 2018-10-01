From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Oct 2018 09:53:15 +0200
Subject: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
 <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
Message-ID: <CAMuHMdW_+PNZrh5JXo8MxVwg3YSZL7bszMcUJjCqMFfBz8HDPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 8:42 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 28, 2018 at 12:21 PM Andreas F?rber <afaerber@suse.de> wrote:
> > Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >> Even x86 can enable OF and OF_UNITTEST.
> > >>
> > >> Another solution might be,
> > >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> > >>
> > >> This is actually what ACPI does.
> > >>
> > >> menuconfig ACPI
> > >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > >>         depends on ARCH_SUPPORTS_ACPI
> > >>          ...
> > >
> > > ACPI is a real platform feature, as it depends on firmware.
> > >
> > > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > > even if it has ACPI ;-)
> >
> > How would loading a DT overlay work on an ACPI platform? I.e., what
> > would it overlay against and how to practically load such a file?
>
> The DT unittests do just that. I run them on x86 and UM builds. In
> this case, the loading source is built-in.
>
> > I wonder whether that could be helpful for USB devices and serdev...
>
> How to load the overlays is pretty orthogonal to the issues to be
> solved here. It would certainly be possible to move forward with
> prototyping this and just have the overlay built-in. It may not even
> need to be an overlay if we can support multiple root nodes.

You indeed need to refer to some anchors for most use cases, although a
simple MMIO device could just be anchored to the root node.

Topologies hanging off a USB device would be my first use case, too,
for serdev, or for e.g. the mcp2210 USB-SPI bridge.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

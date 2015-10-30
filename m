From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 30 Oct 2015 10:15:13 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
In-Reply-To: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CAMuHMdXBcZAXSm1hXv6E-hW9Zp-bPLpp-HxuWukS-Y837LBneQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

On Thu, Oct 29, 2015 at 9:44 PM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> Add an ethernet0 alias for the wired network card and an all 0 default
> mac address so that u-boot can find the device-node and fill in the
> mac address.

Thanks a lot!

I had the same issue on another board, and adding an "ethernet0" alias
fixes it.

> @@ -130,6 +134,8 @@
>  };
>
>  &gmac {
> +       /* To be filled in by U-Boot */
> +       mac-address = [00 00 00 00 00 00];
>         status = "ok";
>  };

Note that in my case I didn't have to add an empty mac-address property.
U-Boot (2015.04-something --- don't have the sources) seems to add a
"local-mac-address" property automatically.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

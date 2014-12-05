From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 5 Dec 2014 10:51:33 +0100
Subject: [PATCH v2] ARM: shmobile: dts: koelsch: Fix flash partition label
 and size
In-Reply-To: <1417746508-14557-1-git-send-email-horms+renesas@verge.net.au>
References: <1417746508-14557-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUMSioEew4UiH3y=qEDuGjG81uw73ajbGiPNSP_OtRkVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 5, 2014 at 3:28 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Update the size and names of flash partitions to match the
> expectations of the loader which are as follows:
>
> "loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
> "user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
> "flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]
>
> ["user"'s assumed breakdown]
> U-boot       (0x0008_0000-0x000c_0000) 256KiB
> bootargs     (0x000c_0000-0x0010_0000) 256KiB
> Device tree  (0x0010_0000-0x0014_0000) 256KiB
> zImage       (0x0014_0000-0x0060_0000) 4.75MiB
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 27 Oct 2015 11:41:05 +0100
Subject: [PATCH v5 0/5] arm64: dts: r8a7795: enable EthernetAVB on
 Salvator-X
In-Reply-To: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWUwMk0U176rq1ax+j=mrnWkPrw9eWPVHnzHHLAJY86pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 8:48 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This patchset enables the EthernetAVB on the Salvator-X board.
> With it and its dependencies in place I have have successfully
> booted to an nfsroot user-space (arm64 Debian Jessie).
>
> In order to achieve that I used the following command line set from u-boot.

> root=/dev/nfs ip=dhcp nfsroot=10.3.3.135:/srv/nfs/salvator-x-arm64

For people who want to try this: you probably want to add a line specifying
the MAC address

        local-mac-address = [ XX XX XX XX XX XX ];

to the avb node in arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Jul 2018 09:43:03 +0200
Subject: Build regressions/improvements in v4.18-rc4
In-Reply-To: <20180709073454.12509-1-geert@linux-m68k.org>
References: <20180709073454.12509-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdUKxMYyqMDnBdeee_L2CKA0Jo=Z=Hs9mirMVYcfKF_WxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 9:37 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc4[1] to v4.18-rc3[3], the summaries are:
>   - build errors: +17/-0

  + error: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko]
undefined!:  => N/A

arm64-allmodconfig (__sync_icache_dcache() needs an EXPORT_SYMBOL_GPL?)

  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
direct-io.c: undefined reference to `__ashldi3':  => .text+0x1858)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mballoc.c: undefined reference to `__ashrdi3':  => .text+0x1bc2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mmio.c: undefined reference to `__lshrdi3':  => .init.text+0x60)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__ashrdi3':  => .text+0x6504)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
tcp_ipv4.c: undefined reference to `__ashldi3':  => .text+0x25ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__ashldi3':  =>
.init.text+0x1ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__lshrdi3':  =>
.init.text+0x1f0), .init.text+0x1ec)
  + error: direct-io.c: undefined reference to `__ashldi3':  =>
.text+0x16a0), .text+0x16a4), .text+0x185c)
  + error: mballoc.c: undefined reference to `__ashldi3':  =>
.text+0x1c46), .text+0x1c70), .text+0x1c4a), .text+0x1c6c)
  + error: mballoc.c: undefined reference to `__ashrdi3':  =>
.text+0x1c0e), .text+0x1c12), .text+0x1bbe)
  + error: mmio.c: undefined reference to `__lshrdi3':  => .init.text+0x5c)
  + error: super.c: undefined reference to `__ashldi3':  =>
.text+0x7fe0), .text+0x7fe4)
  + error: super.c: undefined reference to `__ashrdi3':  => .text+0x6500)
  + error: super.c: undefined reference to `__lshrdi3':  =>
.text+0x7e38), .text+0x7e34)
  + error: tcp_ipv4.c: undefined reference to `__ashldi3':  => .text+0x25a8)
  + error: timekeeping.c: undefined reference to `__ashldi3':  =>
.init.text+0x1a8)

  nds32le/nds32-defconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/1e4b044d22517cae7047c99038abb444423243ca/ (232 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/021c91791a5e7e85c567452f1be3e4c2c6cb6063/ (231 out of 244 configs)Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Dec 2013 15:26:53 +0100
Subject: [PATCH 00/04 v2] ARM: shmobile: r7s72100 and Genmai GPIO /
 PINCTRL V2
In-Reply-To: <20131217050232.727.9552.sendpatchset@w520>
References: <20131217050232.727.9552.sendpatchset@w520>
Message-ID: <CAMuHMdUuG_jiodEvZXGyzK2tz-8BPR6vJA=+zxUw5fBVMVYaNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tue, Dec 17, 2013 at 6:02 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> [PATCH 02/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
> [PATCH 03/04] ARM: shmobile: Genmai LED1 and LED2 support

FWIW,  "[PATCH 02/04] ARM: shmobile: Genmai SCIF2 PINCTRL
configuration" appends to a version of r7s72100-genmai-reference.dts
that's 60 lines long:

--- 0009/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts
2013-11-27 17:13:43.000000000 +0900
@@ -58,3 +58,13 @@
        };

 };
+
+&pfc {
+       pinctrl-0 = <&scif2_pins>;
+       pinctrl-names = "default";
+
+       scif2_pins: serial2 {
+               renesas,groups = "scif2_txd_p3_0", "scif2_rxd_p3_2";
+               renesas,function = "scif2";
+       };
+};

while "[PATCH 03/04] ARM: shmobile: Genmai LED1 and LED2 support"
inserts into a version that has only 31 lines:

@@ -28,4 +29,14 @@
                #address-cells = <1>;
                #size-cells = <1>;
        };
+
+       leds {
+               compatible = "gpio-leds";
+               led1 {
+                       gpios = <&port4 10 GPIO_ACTIVE_LOW>;
+               };
+               led2 {
+                       gpios = <&port4 11 GPIO_ACTIVE_LOW>;
+               };
+       };
 };

Perhaps you reordered or edited them by hand?

Anyway, I managed to apply them by manually,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

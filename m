From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 14 Dec 2015 20:11:37 +0100
Subject: [PATCH/RFC 0/7] ARM: dts: Add compatible property to "partitions" node
Message-ID: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi,

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

I marked this series as "RFC", as the abovementioned commit is not yet
upstream. Ideally, the users should be fixed first, to avoid breakage.

Tested on r8a7791/koelsch.

Thanks!

Geert Uytterhoeven (7):
  ARM: dt: mvebu: ix4-300d: Add compatible property to "partitions" node
  ARM: shmobile: bockw dts: Add compatible property to "partitions" node
  ARM: shmobile: lager dts: Add compatible property to "partitions" node
  ARM: shmobile: koelsch dts: Add compatible property to "partitions"
    node
  ARM: shmobile: porter dts: Add compatible property to "partitions"
    node
  ARM: shmobile: gose dts: Add compatible property to "partitions" node
  ARM: shmobile: silk dts: Add compatible property to "partitions" node

 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 1 +
 arch/arm/boot/dts/r8a7778-bockw.dts             | 1 +
 arch/arm/boot/dts/r8a7790-lager.dts             | 1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts           | 1 +
 arch/arm/boot/dts/r8a7791-porter.dts            | 1 +
 arch/arm/boot/dts/r8a7793-gose.dts              | 1 +
 arch/arm/boot/dts/r8a7794-silk.dts              | 1 +
 7 files changed, 7 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

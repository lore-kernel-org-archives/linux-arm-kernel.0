From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 29 Mar 2017 21:38:52 +0200
Subject: [PATCH v2 0/2] base: soc: soc_device_match() improvements
Message-ID: <1490816334-14568-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Arnd, Greg, Kevin, Magnus, Olof, Simon,

This patch series contains two improvements for the SoC bus and
soc_device_match().  The second one is a dependency for handling
different SoC revisions in the Renesas R-Car SYSC driver, which manages
PM Domains and thus needs to be initialized from an early_initcall[*].

Changes compared to v1:
  - Drop RFC state,
  - Add more explanation,
  - Add Acked-by.

Due to the dependency, and as changes for the Renesas R-Car SYSC driver
typically go in through the renesas and arm-soc trees, and if you agree,
I would like to send a pull request for these changes, to be pulled by
all of the driver core, renesas, and arm-soc trees.  This is similar to
how soc_device_match() was integrated earlier.
Then the Renesas R-Car SYSC driver changes can easily be queued on top
in the renesas tree afterwards.

Do you agree?
Thanks for your answer!

P.S. If you think it's already too late in the cycle to queue Renesas
R-Car SYSC driver changes for v4.12 on top, please say so.  Then the
dependency is relaxed, and this series can just go in through the
driver core tree, with the Renesas part to follow for v4.13.

[*] "[PATCH 0/3] soc: renesas: rcar-sysc: Add support for R-Car H3
     ES2.0" (https://lkml.org/lkml/2017/3/13/833), will send v2 with
     patch description changes only soon.

Geert Uytterhoeven (2):
  base: soc: Let soc_device_match() return no match when called too
    early
  base: soc: Allow early registration of a single SoC device

 drivers/base/soc.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

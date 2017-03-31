From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 31 Mar 2017 10:54:20 +0200
Subject: [git pull] base: soc: Improvements for the SoC bus and
 soc_device_match()
Message-ID: <1490950460-8945-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Greg,
	Hi Arnd, Kevin, Olof,
	Hi Magnus, Simon,

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git tags/soc-device-match-tag2

for you to fetch changes up to 6e12db376b60b7158e4e6006af60566f8c68f7ab:

  base: soc: Allow early registration of a single SoC device (2017-03-29 21:43:26 +0200)

----------------------------------------------------------------
base: soc: Improvements for the SoC bus and soc_device_match()

This is a dependency for handling different SoC revisions in the Renesas
R-Car SYSC driver, which manages PM Domains and thus needs to be
initialized from an early_initcall().

Hence this will serve as an immutable branch between the driver core,
arm-soc, and renesas trees, to allow queueing the Renesas R-Car SYSC
changes on top in the renesas tree.

All changes in this pull request have been Acked by Arnd.

Thanks for pulling!
----------------------------------------------------------------
Geert Uytterhoeven (2):
      base: soc: Let soc_device_match() return no match when called too early
      base: soc: Allow early registration of a single SoC device

 drivers/base/soc.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

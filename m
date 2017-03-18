From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Sat, 18 Mar 2017 08:55:04 +0100
Subject: [PATCH v3 0/5] ASoC: sun8i-a33 clean-up for 4.11
Message-ID: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As discussed in this thread [1], here are a V3 of the cleanup series for
the sun8i-a33 driver (introduced in v4.11-rc1) as fixes for v4.11.

Based on: Linus repository - master branch
Last commit: 8841b5f0cd ("Merge tag 'nfs-for-4.11-2' of
     git://git.linux-nfs.org/projects/anna/linux-nfs")

Changes since v1 and v2:
	- Patch 01: No changes from v1, it applies directly
	- Patch 02: No changes from v1, it applies directly
	once patch 01 has been applied.
	- Patch 03: No changes from v2, it applies directly
	- Patch 04: Rebased on master branch
	- Patch 05: No changes from v2, it applies directly

Patch 01 removes some unnecessary widgets.
Patch 02 updates the driver to use SOC_DAPM_DOUBLE.
Patch 03 removes a space on a widget name that implies an error
on audio routing as the widget is unknown.
Patch 04 improves some widgets (names and types).
As widget names changed in patch 04, the patch 05 is needed to use
the same names on audio routing. Otherwise, the device tree for sun8i-a33
will be broken and the audio codec will not work.

Only patches 01 and 02 were initially wanted as fixes for v4.11 but, with Chen-Yu,
we thought that patch 03 and 04 could be also applied as fixes. As patch 04
creates a break with the device tree, I added patch 05 in this series.

Let me know what you think.

[1]: https://lkml.org/lkml/2017/3/14/4

Thank you in advance,

Best regards,

Myl?ne Josserand (5):
  ASoC: sun8i-codec: Remove analog "HP" widget
  ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
  ASoC: sun8i-codec: Fix space on audio-routing widget
  ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
  ARM: dts: sun8i: Update audio-routing with renamed widgets

 arch/arm/boot/dts/sun8i-a33.dtsi |  4 +--
 sound/soc/sunxi/sun8i-codec.c    | 67 ++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 39 deletions(-)

-- 
2.11.0

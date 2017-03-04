From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  4 Mar 2017 10:52:12 +0100
Subject: [PATCH v2 0/1] meson-gxl: improve support for the P212 board
In-Reply-To: <20170219224114.17201-1-martin.blumenstingl@googlemail.com>
References: <20170219224114.17201-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170304095213.8221-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The P212 board is a reference design and re-used by other boards (similar
to the meson-gxbb-p20x.dtsi which is inherited by the Wetek boards).
Until now only very basic functionality was supported, but most of the
interesting things (wifi, SD, eMMC, IR, etc.) are not enabled yet - which
changes with this patch.

Neil Armstrong kindly took take the information he had from Amlogic for
the P212 board itself and built a list of supported features and
differences with the Khadas VIM boards (which are based on the P212
reference design). This patch is a result of that.

I have tested this with a Khadas VIM board (patch for this will follow)
as I don't have a P212 board itself. Thus it would be nice if someone
could test it on an actual P212 board.

Please also specifically review the copyright statements in
meson-gxl-s905x-p212.dtsi - I want to make sure I didn't mess anything
up there.


Changes since v1:
- update the cover letter to indicate where the information about the
  P212 reference design came from
- use SPDX tags instead of including the full license text
- removed the brcmf sub-node of the sd_emmc_a node as the P212 reference
  design uses a Realtek based wifi chip (and updated the commit
  description accordingly)
- included Neil's Tested-By

Martin Blumenstingl (1):
  ARM64: dts: meson-gxl: improve support for the P212 reference design

 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  21 +--
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 173 +++++++++++++++++++++
 2 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi

-- 
2.12.0

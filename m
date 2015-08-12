From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 12 Aug 2015 19:27:47 +0200
Subject: [PATCH v2] pinctrl: sun4i: add spdif to pin description
Message-ID: <1439400468-1563-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Allwinner A20(sun7i) SoC is pin to pin compatible with the Allwinner
A10(sun4i) SoC. However the user manual for the A10 devices does not make
any reference to the SPDIF whereas the pins, clocks, DMAs and Interrupts
are mentioned in the A20 documentation.

As products exist based on the A10 with an SPDIF transmitter and with the
code exposed then it is safe to assume that we can include SPDIF in the
pin definitions.

We can also look at the fex file of such a device where the SPDIF pin is
defined.
For example
https://github.com/linux-sunxi/sunxi-boards/blob/master/sys_config/a10/mele_a1000.fex#L822
shows
spdif_dout = port:PB13<4><1><default><default>.

Referring to the http://sunxi.org/Fex_Guide#Port_Definitions this shows
that the spdif out pin is PB13 using multiplex function 4. The enabling
of the pull up will be done in the device tree includes and this will be
delivered in a future patch series.

Changes in v2:
-Add comments to highlight that the spdif pins are not officially documented.

Marcus Cooper (1):
  pinctrl: sun4i: add spdif to pin description.

 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.5.0

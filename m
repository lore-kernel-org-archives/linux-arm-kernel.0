From: michael.weiser@gmx.de (Michael Weiser)
Date: Tue,  2 Aug 2016 21:31:10 +0200
Subject: [PATCH 0/5 v3] Fixes for running a big-endian kernel on Cubieboard2
Message-ID: <20160802193115.850-1-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patches fix up endianness problems with DMA descriptors in the
sunxi-mmc and stmmac drivers preventing a big-endian kernel from working
correctly on the Cubieboard2.

The third patch adds the ability to enable diagnostic messages in the
sun4i-emac driver which were instrumental in finding the problem fixed by patch
number four: Endianness confusion caused by dual-purpose I/O register usage in
sun4i-emac.

The final patch enables the big-endian kernel configuration option for sunxi
devices in order to be able to compile a big-endian kernel for the Cubieboard2.
All of these have been tested successfull on a Cubieboard2 DualCard.

Changes since v2:
- Fixed typo in stmmac patch causing a build failure
- Added sun4i-emac patches

Changes since v1:
- Fixed checkpatch niggles
- Added respective Cc:s

Regards,
Michael

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

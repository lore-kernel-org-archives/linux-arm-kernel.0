From: leilk.liu@mediatek.com (leilk.liu at mediatek.com)
Date: Fri, 8 May 2015 16:55:40 +0800
Subject: Add Mediatek SPI driver 
Message-ID: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SPI BUS controller has 3 hardware restrictions:
1. Hw has the restriction that in one transfer, length must be a multiple of
   1024, when it's greater than 1024bytes.
2. Hw tx/rx have 4bytes aligned restriction.
3. For MT8173 IC: RX must enable TX, then TX transfer dummy data; TX don't need
   to enable RX.
Some workarounds are done in SPI driver code base on v4.1-rc1.

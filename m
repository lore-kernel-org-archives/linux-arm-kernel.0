From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri,  7 Nov 2014 10:02:46 +0100
Subject: [PATCHv4 0/1] net: fec: fix regression on i.MX28 introduced by
 rx_copybreak support
Message-ID: <1415350967-2238-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes wrt. v1:
- added some cleanup patches
- simplify handling of 'quirks' flags as suggested by Russell King.
- remove DIV_ROUND_UP() from byte swapping loop as suggested by
  Eric Dumazet

Changes wrt. v2:
- rebased against next-20141028
- added some more cleanups in fec.h
- removed unused return value from swap_buffer()
- fixed messed swab32s() call in swap_buffer2()
- fixed messed up setup of fep->quirks

Changes wrt. v3:
- removed the cleanup patches; will send later to net-next,
  when the bugfix patch has been applied

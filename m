From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Tue, 16 Dec 2014 15:10:54 +0100
Subject: [PATCH 0/4] mmc: sunxi: General fixup (v2)
Message-ID: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
This patchset was inspired questions from ?? of Allwinner and incorporates as
well suggestions from Hans related to spin locks.
For example have not all attributes of the shared host object been protected
by the spin lock, this has been changed.
Also some register names and reset behavior have been fixed now.
And a minor cleanup happened at the clock frequecy setting, since there has
been a piece of left over code which has been there because it was in the Android
driver and we just adapted it because we didn't have proper documentation about
the timing of the module.

Looking forward to your feedback
Cheers David

---

David Lanzend?rfer (3):
      mmc: sunxi: Lock fix
      mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
      mmc: sunxi: Removing unused code

Hans de Goede (1):
      mmc: sunxi: Fix setup of last descriptor of dma transfer


 drivers/mmc/host/sunxi-mmc.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--
Signature

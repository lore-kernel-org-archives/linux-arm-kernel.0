From: wagi@monom.org (Daniel Wagner)
Date: Wed,  3 Aug 2016 14:03:07 +0200
Subject: [PATCH v0 0/4] Use complete() instead of complete_all()
Message-ID: <1470225791-16613-1-git-send-email-wagi@monom.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Using complete_all() is not wrong per se but it suggest that there
might be more than one reader. For -rt I am reviewing all
complete_all() users and would like to leave only the real ones in the
tree. The main problem for -rt about complete_all() is that it can be
uses inside IRQ context and that can lead to unbounded amount work
inside the interrupt handler. That is a no no for -rt.

The patches grouped per subsystem and in small batches to allow
reviewing. Unfortanatly I am not so good in coming up with unique
commit message, so please bear with me in that regard. I could also
squash them together, although each patch containts a very short
reasoning why there is only one waiter. Let me know what you rather
prefer. One patch which updates all complete_all() users or those 4
patches with some reasoning.

It is only test compiled because I don't have the all the hardware.

cheers,
daniel

Daniel Wagner (4):
  i2c: bcm-iproc: Use complete() instead of complete_all()
  i2c: bcm-kona: Use complete() instead of complete_all()
  i2c: brcmstb: Use complete() instead of complete_all()
  i2c: meson: Use complete() instead of complete_all()

 drivers/i2c/busses/i2c-bcm-iproc.c | 2 +-
 drivers/i2c/busses/i2c-bcm-kona.c  | 2 +-
 drivers/i2c/busses/i2c-brcmstb.c   | 2 +-
 drivers/i2c/busses/i2c-meson.c     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4

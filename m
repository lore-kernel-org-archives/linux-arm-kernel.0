From: attila@kinali.ch (Attila Kinali)
Date: Thu, 19 Jul 2012 19:28:14 +0200
Subject: commit 91013923c712e1c:
 "irqdomain: Replace LEGACY mapping with LINEAR" breaks console on ARM
 i.mx23
Message-ID: <20120719192814.75ea8beb784bdf8bb32c510c@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on an embedded system based on a Freescale ARM9 processor i.mx23.

While trying linux-next i stumpled over my login prompt getting broken.
What exactly happens is that the kernel boots normally, but when my
login prompt should appear it suddenly stops. I bisected it back to 
the commit 91013923c712e1c4b9b343f0ee4a86ce72b1b630
irqdomain: Replace LEGACY mapping with LINEAR

Reverting this and the three commits that directly depend on it (see below)
everything seems to work fine again

commit 91013923c712e1c4b9b343f0ee4a86ce72b1b630
    irqdomain: Replace LEGACY mapping with LINEAR
commit 79f3a92c6f1dcbd9aef748252962ec28dab130b8
    irqdomain: Reserve IRQs for legacy domain
commit 1fa5b2108e41a2c6be8f22c4d453fa97e1509f07
    irqdomain: merge linear and tree reverse mappings.


				Attila Kinali

-- 
It is upon moral qualities that a society is ultimately founded. All 
the prosperity and technological sophistication in the world is of no 
use without that foundation.
                 -- Miss Matheson, The Diamond Age, Neil Stephenson

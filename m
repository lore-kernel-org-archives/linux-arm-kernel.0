From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Thu,  3 Jun 2010 15:17:19 +0300
Subject: [PATCH 0/3] ARM: unwind extension
Message-ID: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The first two patches are simply preparation for the third, making it
effectively trivial, even though it's the only one with a concrete 
change in behaviour.

The origins of this patchset are the discovery that unwind and kmemleak
don't always cooperate well with each other - any allocation within 
an exit or devexit function causes kmemleak to look up symbols that 
aren't in any unwind table. This of course means that all WARN_ONs and
BUGs will suffer the same fate.

It could certainly be said that with a typical system the linked list
has grown too large to be practical as a container, and some improvements
could be made in that direction in the future.

Cheers,
Phil

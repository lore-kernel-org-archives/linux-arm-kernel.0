From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 17:32:07 +0100
Subject: [PATCH 0/3] Fix VFP thread handling
Message-ID: <20110709163207.GN4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three holes in the current VFP thread handling:

1. Migration of a thread between CPUs, and then calling vfp_sync_state()
   on the old CPU.

2. When a thread is copied, we weren't ensuring that a reload happened.

3. When a thread is flushed, we weren't ensuring that a reload happened.

These are described in detail in the commit message for patch 3.

These are not targetted at this -rc because it's too risky to put them
in this close to -final.  Once they have been reviewed and tested, they
can be applied to stable trees.

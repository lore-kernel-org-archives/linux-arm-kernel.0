From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed, 12 Aug 2015 14:37:18 +0200
Subject: [PATCH v2] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Message-ID: <55CB3DFE.8060508@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all

A few months ago, Michal Suchanek submitted the attached patch fixing 
the gating timeout issue. Until recently, about v4.0.0 I hadn't noticed 
any issues and ran all boards from SD card.

Recently I upgraded to Hans's 4.2 tree where he added

mmc: sunxi: Don't start commands while the card is busy

which started to trigger the timeout very aggressively causing a pretty 
much unusable system.
While reverting the commands patch also removed the problem for some 
reason, that is of course not the real fix.

Applying Michal's patch on top of the commands patch appears to fix the 
issue on atleast the A20 Lime2.

Attached I have Michal's original patch, rebased to 4.2.0-rc5, with 
Hans's patch applied before hand.

Changed since v1
* Whitespace cleanup as suggested by Maxime Ripard, no functional 
changes from that patch

Olliver
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmc-sunxi-fix-timeout-in-sunxi_mmc_oclk_onoff.patch
Type: text/x-patch
Size: 3023 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/8931b61f/attachment.bin>

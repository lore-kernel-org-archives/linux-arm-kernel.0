From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri,  5 Aug 2016 10:53:19 +0800
Subject: [PATCH 0/3] Support burst request by peripherals
Message-ID: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Burst request is supported by pl330 but the original code
only support single mode as some Socs didn't implement it.
So this feature has been missing for a long time. But it's
very important for efficiency.

This patchset is gonna support it without the probability of
breaking old(other) platforms, so the new optional property
is introduced.

Also when supporting burst request type, we could be able
to deal with unaligned case internally.

After applying this patchset, we could see significant improvement
when doing mem-2-dev/dev-2-mem/mem-2-mem which I mentioned in the
commit msg.

I would appreciate it if folks could help review and test it.:)

Thanks for any feedback.



Shawn Lin (3):
  dt/bindings: arm-pl330: add description of arm,pl330-periph-burst
  dmaengine: pl330: enable burst mode by parsing dt
  dmaengine: pl330: support transfer unaligned with (burst len * burst
    size)

 .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
 drivers/dma/pl330.c                                | 58 +++++++++++++++-------
 2 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.3.7

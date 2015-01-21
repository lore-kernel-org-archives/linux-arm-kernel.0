From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Wed, 21 Jan 2015 09:46:45 +0530
Subject: [RFCv2 0/2] dma-parms, constraints and helpers for dma-buf
Message-ID: <1421813807-9178-1-git-send-email-sumit.semwal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Everyone,

Based on review comments received, I've split my earlier patchset on
'dma-buf constraints-enabled allocation' [1] into 2 sets:
- first one is this one, to use dma_parms and related parameters from
   struct device to share constraints, and then to use these constraints in
   dma-buf to help find the least common constraint set that could then be
   used by exporters to decide on allocation.

   This is a partial re-write of what Rob Clark proposed some while ago [2];
   I've tried to take care of review comments on his patchset, but any errors
   and omissions are, ofcourse, mine.

- Second part, one which I'm working on, and will post soon, aims at adding
   allocator-helpers in dma-buf framework which could use this constraint
   information to help choose the right allocator from a list.

While I work on the second part, I thought of sending the RFC for this one,
to get feedback on whether this mechanism seems ok to everyone.

[1] https://lkml.org/lkml/2014/10/10/340
[2] https://lkml.org/lkml/2012/7/19/285

Rob Clark (1):
  device: add dma_params->max_segment_count

Sumit Semwal (1):
  dma-buf: add helpers for sharing attacher constraints with dma-parms

 drivers/dma-buf/dma-buf.c   | 134 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h      |   1 +
 include/linux/dma-buf.h     |  22 ++++++++
 include/linux/dma-mapping.h |  19 +++++++
 4 files changed, 175 insertions(+), 1 deletion(-)

-- 
1.9.1

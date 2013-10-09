From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 10 Oct 2013 00:37:59 +0200
Subject: [PATCH v2 0/7] iommu/arm-smmu: Misc modifications to support SMMUs on
 Calxeda ECX-2000
Message-ID: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is v2 of arm-smmu changes to support SMMUs on Calxeda ECX-2000.

Note that patch 7/7 (Introduce automatic stream-id-masking) is not
required to support SMMUs on Calxeda ECX-2000. In fact the algorithm
implemented won't help to determine a suitable smr-mask for 10
StreamIDs that we have for SATA.

In case of 2, 4, 8, ... (power-of-two) ... number of StreamIDs for a
master device it might be able (depending on further restriction for
the StreamIDs) to determine the right mask which then allows to use
only one SMR group for stream matching for this master instead of
using several SMR groups (one for each StreamID).

Changelog:
v2:
- Modified options handling
- Added patch to document new DT properties (that select driver options)
- Added patch to introduce automatic stream-id-masking
v1:
   http://marc.info/?l=linux-arm-kernel&m=138122450023564


Regards,
Andreas

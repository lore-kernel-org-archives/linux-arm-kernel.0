From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 10 Dec 2015 11:52:15 +0300
Subject: [PATCH v2 0/2] net: thunderx: Support for pass-2 hw features
In-Reply-To: <1449734120-8912-1-git-send-email-sunil.kovvuri@gmail.com>
References: <y@samsung.com>
 <1449734120-8912-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <008f01d13328$1220e870$3662b950$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 All series:

 Reviewed-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On Behalf Of Sunil Goutham
Sent: Thursday, December 10, 2015 10:55 AM
To: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; p.fedin at samsung.com; Sunil.Goutham at caviumnetworks.com; Sunil
Goutham
Subject: [PATCH v2 0/2] net: thunderx: Support for pass-2 hw features

From: Sunil Goutham <sgoutham@cavium.com>

This patch set adds support for new features added in pass-2 revision of hardware like TSO and count based interrupt coalescing.

Changes from v1:
- Addressed comments received regarding boolean bit field changes
  by excluding them from this patch. Will submit a seperate
  patch along with cleanup of unsed field.
- Got rid of new macro 'VNIC_NAPI_WEIGHT' introduced in
  count threshold interrupt patch.

Sunil Goutham (2):
  net: thunderx: HW TSO support for pass-2 hardware
  net: thunderx: Enable CQE count threshold interrupt

 drivers/net/ethernet/cavium/thunder/nic.h          |    6 ++++
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   11 ++-----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   15 ++++++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   22 ++++++++++----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    2 +-
 drivers/net/ethernet/cavium/thunder/q_struct.h     |   30 ++++++++++---------
 6 files changed, 55 insertions(+), 31 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe netdev" in the body of a message to majordomo at vger.kernel.org More
majordomo info at  http://vger.kernel.org/majordomo-info.html

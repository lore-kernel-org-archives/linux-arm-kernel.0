From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Thu, 28 Jan 2010 23:06:00 -0800
Subject: [PATCH v2 0/4] GIC Changes
Message-ID: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Few fixes and improvements to arch/arm/common/gic.c file. 

Changes in v2

Russell indicated that there could be an on chip inteverter on some interrupt
lines and hence there is no way to enforce correct edge rising/falling or level
high/low configuration. The change to introduce set_type callback is dropped.

Also the change to configure SPI's and PPI's as level/edge  depending on the
flow_type argument passed in gic_dist_init is dropped. 

As per Catalin's suggestion all the interrupts reported by gic are
disabled. This way we initialize and disable all the unused interrupts.
The iterator,i in the gic_dist_init is still prevented from exceeding NR_IRQS.

As per Ben Dook's suggestion 'gic:...' is changed to 'GIC:...' in title.

Thanks for all your inputs. Please let me know if further changes are
required.

Abhijeet Dharmapurikar (4):
  GIC: Disable unused interrupts
  GIC: Prevent gic from crossing NR_IRQS
  GIC: Add callback for mask_ack
  GIC: Dont disable INT in ack callback

 arch/arm/common/gic.c |   56 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 18 deletions(-)

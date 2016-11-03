From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  3 Nov 2016 14:54:34 -0700
Subject: [PATCH] PM / Domains: Fix for domain idle state
Message-ID: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

This follows the discussions we had at LPC. The decision to use a different
compatible (different from that of the CPU's idle state) resulted in a new idle
state node definition that is specific to PM domains. The patch describes this
new binding.

You have already pulled in my earlier changes for domain idle states into your
linux-next. This patch is intended to be applied on top of that and fixes the
domain idle state and maps it to the new definition.

Thanks,
Lina

Lina Iyer (1):
  PM / Domains: Fix compatible for domain idle state

 .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
 .../devicetree/bindings/power/power_domain.txt     |  8 +++---
 drivers/base/power/domain.c                        |  2 +-
 3 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt

-- 
2.7.4

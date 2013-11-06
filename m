From: vkale@apm.com (Vinayak Kale)
Date: Wed,  6 Nov 2013 17:37:35 +0530
Subject: [PATCH 0/2] genirq: arm64: perf: support for percpu pmu interrupt
Message-ID: <1383739658-10036-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support to handle interrupt registration/deregistration
in arm64 pmu driver when pmu interrupt type is percpu.

Patches in this patch series were previously sent out as separate patches [1].
This patch series incorporates comments/fixes suggested for original patches.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205888.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204414.html 

Vinayak Kale (2):
  genirq: error reporting in request_percpu_irq() and
    request_threaded_irq()
  arm64: perf: add support for percpu pmu interrupt

 arch/arm64/kernel/perf_event.c |  109 +++++++++++++++++++++++++++++-----------
 kernel/irq/manage.c            |   12 +++--
 2 files changed, 89 insertions(+), 32 deletions(-)

-- 
1.7.9.5

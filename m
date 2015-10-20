From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 16:58:25 +0900
Subject: [PATCH 0/2] arm64: kexec/kdump fixes for v10
Message-ID: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches should be applied on top of Geoff's kexec/kdump patch[1],
v10, to fix some issues. I should have merged it before the submission
but I missed the timing. Sorry.

Please go ahead and review v10 since these patches don't change any
main logic of kexec/kdump. I will merge them in the next submission.

Patch 1 fixes a cpuidle issue reported by James[2].

Patch 2 allows kdump to start a crash kernel even with a kvm guest still
running. (I accidentally dropped this hack when rebasing my part.)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379268.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376460.html

AKASHI Takahiro (2):
  fixup! arm64: kdump: implement machine_crash_shutdown()
  fixup! arm64: kvm: allows kvm cpu hotplug

 arch/arm/kvm/arm.c                |   25 +++++++++++++++++++++----
 arch/arm64/kernel/machine_kexec.c |    2 +-
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
1.7.9.5

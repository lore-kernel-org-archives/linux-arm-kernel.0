From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Oct 2017 14:24:39 +0100
Subject: [PATCH 3/4] kvm/arm64: simplify CC instrumentation opt-out
In-Reply-To: <20171016132440.38098-1-mark.rutland@arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
Message-ID: <20171016132440.38098-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can opt out of all instrumentation with a single option,
make use of this in the KVM hyp code. Hopefully, this will also avoid
fragility as new options are introduced.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <mark.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kvm/hyp/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 14c4e3b14bcb..a8a212eb66f1 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -22,7 +22,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
 # cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
+CC_INSTRUMENT	:= n
-- 
2.11.0

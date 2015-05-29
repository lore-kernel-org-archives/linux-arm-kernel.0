From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 29 May 2015 10:30:27 +0100
Subject: [PATCH v5 11/12] KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG
In-Reply-To: <1432891828-4816-1-git-send-email-alex.bennee@linaro.org>
References: <1432891828-4816-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1432891828-4816-12-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally advertise the KVM capability for SET_GUEST_DEBUG. Once arm
support is added this check can be moved to the common
kvm_vm_ioctl_check_extension() code.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

---

v3:
 - separated capability check from previous patches
 - moved into arm64 specific ioctl handler.
v4:
 - add a-b-tag
---
 arch/arm64/kvm/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 21d5a62..88e5331 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -76,6 +76,9 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_GUEST_DEBUG_HW_WPS:
 		r  = get_num_wrps();
 		break;
+	case KVM_CAP_SET_GUEST_DEBUG:
+		r = 1;
+		break;
 	default:
 		r = 0;
 	}
-- 
2.4.1

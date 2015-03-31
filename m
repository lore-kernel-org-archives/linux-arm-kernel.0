From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:07:59 +0100
Subject: [PATCH v2 01/10] KVM: add commentary for kvm_debug_exit_arch struct
In-Reply-To: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427814488-28467-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring into line with the commentary for the other structures and their
KVM_EXIT_* cases.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---

v2
  - add comments for other exit types

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8055706..5eedf84 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -226,6 +226,7 @@ struct kvm_run {
 			__u32 count;
 			__u64 data_offset; /* relative to kvm_run start */
 		} io;
+		/* KVM_EXIT_DEBUG */
 		struct {
 			struct kvm_debug_exit_arch arch;
 		} debug;
@@ -274,6 +275,7 @@ struct kvm_run {
 			__u32 data;
 			__u8  is_write;
 		} dcr;
+		/* KVM_EXIT_INTERNAL_ERROR */
 		struct {
 			__u32 suberror;
 			/* Available with KVM_CAP_INTERNAL_ERROR_DATA: */
@@ -284,6 +286,7 @@ struct kvm_run {
 		struct {
 			__u64 gprs[32];
 		} osi;
+		/* KVM_EXIT_PAPR_HCALL */
 		struct {
 			__u64 nr;
 			__u64 ret;
-- 
2.3.4

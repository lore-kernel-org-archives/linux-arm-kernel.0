From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:00 -0500
Subject: [RFC 04/55] KVM: arm64: Allow userspace to set PSR_MODE_EL2x
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-5-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

We were not allowing userspace to set a more privileged mode for the VCPU
than EL1, but now that we support nesting with a virtual EL2 mode, do
allow this!

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/guest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3f9e157..6b9f38a 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -117,6 +117,8 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		case PSR_MODE_EL0t:
 		case PSR_MODE_EL1t:
 		case PSR_MODE_EL1h:
+		case PSR_MODE_EL2h:
+		case PSR_MODE_EL2t:
 			break;
 		default:
 			err = -EINVAL;
-- 
1.9.1

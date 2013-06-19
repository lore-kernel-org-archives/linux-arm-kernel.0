From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 14:20:06 +0100
Subject: [PATCH 5/5] ARM: KVM: issue a DSB after cache maintainance operations
In-Reply-To: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371648006-8036-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When performing the Set/Way cache maintainance operations, it is
important to make sure the operation completes by issueing a DSB.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 4a51990..9e6bef4 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -106,6 +106,8 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
 		break;
 	}
 
+	dsb();
+
 done:
 	put_cpu();
 
-- 
1.8.2.3

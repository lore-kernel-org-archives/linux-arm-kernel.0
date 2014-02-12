From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Wed, 12 Feb 2014 14:52:38 +0530
Subject: [PATCH] arm64: fix psci power state pack
Message-ID: <1392196958-2507-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Values has to be shifted right to create pack.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm64/kernel/psci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4f97db3..6e8f1df 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -87,11 +87,11 @@ static int psci_to_linux_errno(int errno)
 static u32 psci_power_state_pack(struct psci_power_state state)
 {
 	return	((state.id & PSCI_POWER_STATE_ID_MASK)
-			<< PSCI_POWER_STATE_ID_SHIFT)	|
+			>> PSCI_POWER_STATE_ID_SHIFT)	|
 		((state.type & PSCI_POWER_STATE_TYPE_MASK)
-			<< PSCI_POWER_STATE_TYPE_SHIFT)	|
+			>> PSCI_POWER_STATE_TYPE_SHIFT)	|
 		((state.affinity_level & PSCI_POWER_STATE_AFFL_MASK)
-			<< PSCI_POWER_STATE_AFFL_SHIFT);
+			>> PSCI_POWER_STATE_AFFL_SHIFT);
 }
 
 /*
-- 
1.7.4.1

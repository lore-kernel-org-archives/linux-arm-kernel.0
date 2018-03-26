From: peng.hao2@zte.com.cn (Peng Hao)
Date: Tue, 27 Mar 2018 01:07:17 +0800
Subject: [PATCH] KVM: arm/armv4 : merge the same case handler
Message-ID: <1522084037-85559-1-git-send-email-peng.hao2@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two switch cases have the same handler, so merge them.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 4650953..aa41b29 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1242,8 +1242,6 @@ static int vgic_its_handle_command(struct kvm *kvm, struct vgic_its *its,
 		ret = vgic_its_cmd_handle_mapc(kvm, its, its_cmd);
 		break;
 	case GITS_CMD_MAPI:
-		ret = vgic_its_cmd_handle_mapi(kvm, its, its_cmd);
-		break;
 	case GITS_CMD_MAPTI:
 		ret = vgic_its_cmd_handle_mapi(kvm, its, its_cmd);
 		break;
-- 
1.8.3.1

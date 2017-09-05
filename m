From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  5 Sep 2017 16:52:04 +0200
Subject: [PULL 5/8] KVM: arm/arm64: vgic: constify seq_operations and
 file_operations
In-Reply-To: <20170905145207.18447-1-cdall@linaro.org>
References: <20170905145207.18447-1-cdall@linaro.org>
Message-ID: <20170905145207.18447-6-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

vgic_debug_seq_ops and file_operations are not supposed to change
at runtime and none of the structures is modified.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
index 7072ab7..10b3817 100644
--- a/virt/kvm/arm/vgic/vgic-debug.c
+++ b/virt/kvm/arm/vgic/vgic-debug.c
@@ -234,7 +234,7 @@ static int vgic_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static struct seq_operations vgic_debug_seq_ops = {
+static const struct seq_operations vgic_debug_seq_ops = {
 	.start = vgic_debug_start,
 	.next  = vgic_debug_next,
 	.stop  = vgic_debug_stop,
@@ -255,7 +255,7 @@ static int debug_open(struct inode *inode, struct file *file)
 	return ret;
 };
 
-static struct file_operations vgic_debug_fops = {
+static const struct file_operations vgic_debug_fops = {
 	.owner   = THIS_MODULE,
 	.open    = debug_open,
 	.read    = seq_read,
-- 
2.9.0

From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 11 May 2018 20:06:12 +0100
Subject: [PATCH v2 11/40] mm: export symbol find_get_task_by_vpid
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Message-ID: <20180511190641.23008-12-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace drivers implemented with VFIO might want to bind sub-processes
to their devices. In a VFIO ioctl, they provide a pid that is used to find
a task and its mm. Since VFIO can be built as a module, export the
find_get_task_by_vpid symbol.

Cc: akpm at linux-foundation.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

---
Here I didn't add a comment because neighbouring functions that get
exported don't have a comment either, and the name seems fairly clear.
---
 kernel/pid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..0b6d3201c42d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -355,6 +355,7 @@ struct task_struct *find_get_task_by_vpid(pid_t nr)
 
 	return task;
 }
+EXPORT_SYMBOL_GPL(find_get_task_by_vpid);
 
 struct pid *get_task_pid(struct task_struct *task, enum pid_type type)
 {
-- 
2.17.0

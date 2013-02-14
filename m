From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 14 Feb 2013 09:14:30 +0100
Subject: [PATCH v9 8/8] watchdog: code: fix the alignement of some function
 declarations
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1360829670-10418-9-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
---
 drivers/watchdog/watchdog_core.c |  2 +-
 drivers/watchdog/watchdog_dev.c  | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 05d18b4..5cdd7b6 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -70,7 +70,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * A zero is returned on success and -EINVAL for failure.
  */
 int watchdog_init_timeout(struct watchdog_device *wdd,
-				unsigned int timeout_parm, struct device *dev)
+			  unsigned int timeout_parm, struct device *dev)
 {
 	unsigned int t = 0;
 	int ret = 0;
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 08b48bb..776341b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -162,8 +162,7 @@ out_stop:
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wddev,
-							unsigned int *status)
+static int watchdog_get_status(struct watchdog_device *wddev, uint *status)
 {
 	int err = 0;
 
@@ -191,8 +190,7 @@ out_status:
  *	@timeout: timeout to set in seconds
  */
 
-static int watchdog_set_timeout(struct watchdog_device *wddev,
-							unsigned int timeout)
+static int watchdog_set_timeout(struct watchdog_device *wddev, uint timeout)
 {
 	int err;
 
@@ -225,8 +223,7 @@ out_timeout:
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
-static int watchdog_get_timeleft(struct watchdog_device *wddev,
-							unsigned int *timeleft)
+static int watchdog_get_timeleft(struct watchdog_device *wddev, uint *timeleft)
 {
 	int err = 0;
 
@@ -255,8 +252,7 @@ out_timeleft:
  *	@arg: argument pointer
  */
 
-static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
-							unsigned long arg)
+static int watchdog_ioctl_op(struct watchdog_device *wddev, uint cmd, ulong arg)
 {
 	int err;
 
@@ -290,7 +286,7 @@ out_ioctl:
  */
 
 static ssize_t watchdog_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+			      size_t len, loff_t *ppos)
 {
 	struct watchdog_device *wdd = file->private_data;
 	size_t i;
@@ -329,8 +325,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
  *	according to their available features.
  */
 
-static long watchdog_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
+static long watchdog_ioctl(struct file *file, unsigned int cmd, ulong arg)
 {
 	struct watchdog_device *wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
-- 
1.8.1.1

From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:57 +0300
Subject: [PATCH 11/14] staging: fsl-mc: fix a few implicit includes
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-12-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Few files using byte order macros but did not explicitly
included the required kernel header, so add it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp.c      | 1 +
 drivers/staging/fsl-mc/bus/dpcon.c     | 1 +
 drivers/staging/fsl-mc/bus/dpio/dpio.c | 1 +
 drivers/staging/fsl-mc/bus/dpmcp.c     | 1 +
 drivers/staging/fsl-mc/bus/dprc.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index d9e450a..e92d887 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -29,6 +29,7 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
 #include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 #include "../include/dpbp.h"
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index eb71357..20df185 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -29,6 +29,7 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
 #include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 #include "../include/dpcon.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index d81e023..a18ca89 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -30,6 +30,7 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
 #include "../../include/mc-sys.h"
 #include "../../include/mc-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/staging/fsl-mc/bus/dpmcp.c
index ad4c8b4..66011e8 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/staging/fsl-mc/bus/dpmcp.c
@@ -29,6 +29,7 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
 #include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/staging/fsl-mc/bus/dprc.c
index a47f31d..e5dfc33 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/staging/fsl-mc/bus/dprc.c
@@ -29,6 +29,7 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
 #include "../include/mc.h"
 #include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
-- 
2.9.4

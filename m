From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 15:52:10 +0300
Subject: [PATCH] staging: fsl-dpaa2/eth: fix a couple of implicit includes
Message-ID: <20170622125210.27269-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

dpni.c is using byte order macros and error codes but does
not explicitly include the required kernel header, so add it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index cea46ed..2c4b1a8 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -30,6 +30,8 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/kernel.h>
+#include <linux/errno.h>
 #include "../../fsl-mc/include/mc-sys.h"
 #include "../../fsl-mc/include/mc-cmd.h"
 #include "dpni.h"
-- 
2.9.4

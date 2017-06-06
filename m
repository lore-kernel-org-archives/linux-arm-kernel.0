From: khilman@baylibre.com (Kevin Hilman)
Date: Tue,  6 Jun 2017 16:37:37 -0700
Subject: [PATCH v2 0/4] [media] davinci: vpif_capture: raw camera support
Message-ID: <20170606233741.26718-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same as v1, just rebased onto master branch of media tree, as
requested by Hans.

This series fixes/updates the support for raw camera input to the VPIF.

Tested on da850-evm boards using the add-on UI board.  Tested with
both composite video input (on-board tvp514x) and raw camera input
using the camera board from On-Semi based on the aptina,mt9v032
sensor[1], as this was the only camera board with the right connector
for the da850-evm UI board.

Verified that composite video capture is still working well after these
updates.

[1] http://www.mouser.com/search/ProductDetail.aspx?R=0virtualkey0virtualkeyMT9V032C12STCH-GEVB

Kevin Hilman (4):
  [media] davinci: vpif_capture: drop compliance hack
  [media] davinci: vpif_capture: get subdevs from DT when available
  [media] davinci: vpif_capture: cleanup raw camera support
  [media] davinci: vpif: adaptions for DT support

 drivers/media/platform/davinci/vpif.c         |  49 +++++-
 drivers/media/platform/davinci/vpif_capture.c | 223 +++++++++++++++++++++++---
 drivers/media/platform/davinci/vpif_display.c |   5 +
 include/media/davinci/vpif_types.h            |   9 +-
 4 files changed, 262 insertions(+), 24 deletions(-)

-- 
2.9.3

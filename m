From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Feb 2015 19:19:26 +0800
Subject: [PATCH v10 0/2] mfd: axp20x: Add DT binding documentation
Message-ID: <1424431168-25157-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v10 of the axp20x series. v10 reverts back to the DT bindings
from v8. This is the binding currently supported by the kernel drivers
since 3.18. Mark Brown raised concern on the needless changes to
active regulator bindings in v9.

Maxime, I dropped your Acked-by because of all the changes I've made.
Please have a look again.

Mark (Brown), please take a look at the regulator bits in the second
patch. If it looks good, could you give your Acked-by?

I hope we can get this series merged so we can move on to adding
AXP221 support.


Regards,
ChenYu


Changes since v9:

    - Revert to bindings in v8
    - Dropped new patches in v9
    - x-powers,dcdc-workmode default changed to "current hardware setting",
      matching the regulator driver.
    - Reorganized regulator related properties into separate section.
      This should make it easier to read and also update for newer PMICs.
    - Regulator nodes should only be listed if they are to be managed by
      the OS.


Carlo Caione (2):
  mfd: AXP20x: Add bindings documentation
  dt-bindings: add vendor-prefix for X-Powers

 Documentation/devicetree/bindings/mfd/axp20x.txt   | 96 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

-- 
2.1.4

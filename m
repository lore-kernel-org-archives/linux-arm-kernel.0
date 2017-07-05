From: biju.das@bp.renesas.com (Biju Das)
Date: Wed,  5 Jul 2017 16:56:27 +0100
Subject: [PATCH v2 0/2] Add RZ/G1M (R8A7743) Ethernet AVB support
In-Reply-To: <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
References: <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
Message-ID: <1499270189-29945-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series aims to upstream the Ethernet AVB driver support for RZ/G1M (r8a7743) SoC . 

The iWave RZ/G1M Qseven SOM supports Gigabit Ethernet Phy from Micrel(KSZ9031MNX).
Gigabit Ethernet support is available in Renesas AVB driver.

This series has been tested against linux-next tag next-20170704.

Modifications:
v1->v2
-Dropped the driver update,as is it not needed due to the presence of family-specific compatible values.
-Added Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> for the DT binding patch
-Added Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> for the defconfig: Enable Ethernet AVB patch

History:
-------
[v1]: https://www.spinics.net/lists/arm-kernel/msg592366.html

Biju Das (2):
  ravb: Document binding for r8a7743 SoC
  ARM: shmobile: defconfig: Enable Ethernet AVB

 Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
 arch/arm/configs/shmobile_defconfig                    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
1.9.1

From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  3 Mar 2015 11:39:38 -0800
Subject: [PATCH v2 0/3] drivers: net: xgene: Fix backward compatibility of
 newer firmware with older kernel
Message-ID: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel 3.17 driver supports only RGMII ethernet interface.
Since the Tianocore DT contains same compatibility string for RGMII,
SGMII based 1G and XFI based 10G interfaces, crash happens when probe called
on SGMII based 1G and XFI based 10G interface.

This patch fixes the backward compatibility of the older driver with the
newer firmware by making the binding unique so that the older driver won't
recognize the non-supported interfaces.

v2: Address comments from v1
* updated cover letter subject line with net: xgene
* Documentation: formatted compatible string values as list

v1:
* Initial version
---

Iyappan Subramanian (3):
  Documentation: dts: Update compatible field description for APM X-Gene
  dtb: change binding name to match with newer firmware DT
  drivers: net: xgene: fix new firmware backward compatibility with
    older driver

 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 5 ++++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi                   | 4 ++--
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c         | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.9.1

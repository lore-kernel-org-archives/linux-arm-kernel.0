From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 29 Jun 2016 11:27:53 +0800
Subject: [PATCH v2 0/5] arm64: hisilicon: Hip0x dt/config update
In-Reply-To: <1467093105-1568-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467093105-1568-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1467170878-24030-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT update:
1) Hip05
- Kill unuesd hip05_hns.dtsi
2) Hip06
- Add SAS/HNS node

CONFIG update:
1) Enable SAS/HNS config

Changes since v1:
- Add dt binding document suggested by Wei xu and use better name.

Kefeng Wang (5):
  arm64: dts: hip05: kill hip05_hns.dtsi
  dt-bindings: hisilicon: Add Hip05 and Hip06 system controller support
  arm64: dts: hip06: Append hns node
  arm64: dts: hip06: Append sas node
  arm64: defconfig: Enable Hisi SAS and HNS

 .../bindings/arm/hisilicon/hisilicon.txt           |  39 ++-
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   5 -
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi       | 180 ----------
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |  28 ++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           | 365 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   5 +-
 6 files changed, 425 insertions(+), 197 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi

-- 
1.7.12.4

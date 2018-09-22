From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 22 Sep 2018 22:57:26 +0200
Subject: [PATCH v3 0/4] Add 96Boards Rock960 CE board support
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Message-ID: <1927657.aQyVdf9HM0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. September 2018, 20:05:41 CEST schrieb Manivannan Sadhasivam:
> This patchset adds 96Boards Rock960 CE board support. Rock960 CE
> (Consumer Edition) board is one of the member of 96Boards Consumer
> Edition and AI platform and is manufactured by Vamrs Limited. Most of
> the board configuration is shared with the Ficus board manufactured by
> vamrs, which is an Enterprise 96Board.
> 
> For the sake of avoiding code duplication, a common rock960.dtsi file
> with common DT nodes for both boards and separate board specific DTS
> files has been added.
> 
> To be specific, below are some of the key differences between both
> boards:
> 
> 1. Different host enable GPIO for USB
> 2. Different power and reset GPIO for PCI-E
> 3. No Ethernet port on Rock960
> 
> While adding the board support, SD card Chip detection support is also
> added to the common dtsi file, shared by both boards.
> 
> This series has been tested on Rock960 CE v1.2 board.
> 
> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Moved usb and pcie nodes to common dtsi and kept only the properties
>   which differ in board specific dts.
> * Updated the common dtsi commit description.
> 
> Changes in v2:
> 
> * Changed the board compatible to "vamrs,rock960"
> 
> Manivannan Sadhasivam (4):
>   arm64: dts: rockchip: Split out common nodes for Rock960 based boards
>   dt-bindings: arm: rockchip: Add binding for Rock960 board
>   arm64: boot: dts: rockchip: Add support for Rock960 board
>   arm64: dts: rockchip: Enable SD card detection for Rock960 boards

applied all 4 for 4.20, after fixing the subject of patch3 (-boot:)
and adapting to recent Makefile changes as pointed out by
Ezequiel.

Heiko

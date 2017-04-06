From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 6 Apr 2017 15:41:57 +0530
Subject: [PATCH V8 0/4] phy: USB and PCIe phy drivers for Qcom chipsets
In-Reply-To: <1491457885-5254-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1491457885-5254-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <9f928f13-3bee-6f36-6760-095da5a03495@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 06 April 2017 11:21 AM, Vivek Gautam wrote:
> Hi Kishon,
> Here's the series with fixed checkpatch warnings/checks.
> Please pick it for phy/next.
> 
> This patch series adds couple of PHY drivers for Qualcomm chipsets.
> a) qcom-qusb2 phy driver: that provides High Speed USB functionality.
> b) qcom-qmp phy driver: that is a combo phy providing support for
>    USB3, PCIe, UFS and few other controllers.
> 
> The patches are based on next branch of linux-phy tree.
> 
> These patches have been tested on Dragon board db820c hardware with
> required set of dt patches.
> The tested branch[3] is based on torvald's master with greg's usb/usb-next
> merged. Additionally the patches to get rpm up on msm8996 are also pulled
> in.

merged, thanks!

-Kishon
> 
> Changes since v7:
>  - Fixed 'checkpatch --strict' alignment warnings/checks, and
>    added Stephen's Reviewed-by tag.
> 
> Changes since v6:
>  - Rebased on phy/next and *not* including phy grouping series[4].
>  - qusb2-phy: addressed Stephen's comment.
>    - Dropped pm8994_s2 corner regulator from QUSB2 phy bindings.
>  - qmp-phy: none on functionality side.
>  
> Changes since v5:
>  - Addressed review comments from Bjorn:
>    - Removed instances of readl/wirtel_relaxed calls from the drivers.
>      Instead, using simple readl/writel. Inserting a readl after a writel
>      to ensure the write is through to the device.
>    - Replaced regulator handling with regulator_bulk_** apis. This helps
>      in cutting down a lot of regulator handling code.
>    - Fixed minor return statements.
> 
> Changes since v4:
>  - Addressed comment to add child nodes for qmp phy driver. Each phy lane
>    now has a separate child node under the main qmp node.
>  - Modified the clock and reset initialization and enable methods.
>    Different phys - pcie, usb and later ufs, have varying number of clocks
>    and resets that are mandatory. So adding provision for clocks and reset
>    lists helps in requesting all mandatory resources for individual phys
>    and handle their failure cases accordingly.
> 
> Changes since v3:
>  - Addressed review comments given by Rob and Stephen for qusb2 phy
>    and qmp phy bindings respectively.
>  - Addressed review comments given by Stephen and Bjorn for qmp phy driver.
> 
> Changes since v2:
>  - Addressed review comments given by Rob and Stephen for bindings.
>  - Addressed the review comments given by Stephen for the qusb2 and qmp
>    phy drivers.
> 
> Changes since v1:
>  - Moved device tree binding documentation to separate patches, as suggested
>    by Rob.
>  - Addressed review comment regarding qfprom accesses by qusb2 phy driver,
>    given by Rob.
>  - Addressed review comments from Kishon.
>  - Addressed review comments from Srinivas for QMP phy driver.
>  - Addressed kbuild warning.
> 
> Please see individual patches for detailed changelogs.
> 
> [1] https://patchwork.kernel.org/patch/9567767/
> [2] https://patchwork.kernel.org/patch/9567779/
> [3] https://github.com/vivekgautam1/linux/tree/linux-v4.11-rc5-qmp-phy-db820c
> [4] https://lkml.org/lkml/2017/3/20/407
> 
> Vivek Gautam (4):
>   dt-bindings: phy: Add support for QUSB2 phy
>   phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips
>   dt-bindings: phy: Add support for QMP phy
>   phy: qcom-qmp: new qmp phy driver for qcom-chipsets
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  106 ++
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   43 +
>  drivers/phy/Kconfig                                |   18 +
>  drivers/phy/Makefile                               |    2 +
>  drivers/phy/phy-qcom-qmp.c                         | 1153 ++++++++++++++++++++
>  drivers/phy/phy-qcom-qusb2.c                       |  493 +++++++++
>  6 files changed, 1815 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-qmp.c
>  create mode 100644 drivers/phy/phy-qcom-qusb2.c
> 

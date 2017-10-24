From: chenyu56@huawei.com (Yu Chen)
Date: Tue, 24 Oct 2017 14:06:07 +0800
Subject: [RFC 0/3] USB: Modify dwc3 code for support Hikey960
Message-ID: <20171024060610.10712-1-chenyu56@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HiKey960 development platform is based around the HiSilicon Kirin960.
The patch sets add support for usb of HiKey960.

Fan Ning (3):
  Add document for usb of Hikey960
  Modify dwc3 code for support usb of Hikey960
  Modify device tree for support Hikey960

 .../devicetree/bindings/usb/hisilicon-usb.txt      |   38 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   39 +
 arch/arm64/configs/defconfig                       |    5 +
 drivers/usb/dwc3/Kconfig                           |   26 +
 drivers/usb/dwc3/Makefile                          |    5 +
 drivers/usb/dwc3/core.c                            |   78 +-
 drivers/usb/dwc3/core.h                            |   19 +-
 drivers/usb/dwc3/dwc3-hi3660.c                     |  310 +++
 drivers/usb/dwc3/dwc3-hisi.c                       | 1972 ++++++++++++++++++++
 drivers/usb/dwc3/dwc3-hisi.h                       |  293 +++
 drivers/usb/dwc3/dwc3-otg.c                        |  360 ++++
 drivers/usb/dwc3/dwc3-otg.h                        |  133 ++
 drivers/usb/dwc3/ep0.c                             |   55 +-
 drivers/usb/dwc3/gadget.c                          |   20 +-
 drivers/usb/dwc3/hisi_hikey_gpio.c                 |  300 +++
 drivers/usb/dwc3/host.c                            |   13 +
 drivers/usb/dwc3/io.h                              |   14 +
 include/linux/hisi/log/hisi_log.h                  |  143 ++
 include/linux/hisi/usb/hisi_hikey_gpio.h           |   24 +
 include/linux/hisi/usb/hisi_usb.h                  |   57 +
 20 files changed, 3896 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon-usb.txt
 mode change 100644 => 100755 arch/arm64/boot/dts/hisilicon/hi3660.dtsi
 create mode 100644 drivers/usb/dwc3/dwc3-hi3660.c
 create mode 100644 drivers/usb/dwc3/dwc3-hisi.c
 create mode 100644 drivers/usb/dwc3/dwc3-hisi.h
 create mode 100644 drivers/usb/dwc3/dwc3-otg.c
 create mode 100644 drivers/usb/dwc3/dwc3-otg.h
 create mode 100644 drivers/usb/dwc3/hisi_hikey_gpio.c
 create mode 100644 include/linux/hisi/log/hisi_log.h
 create mode 100644 include/linux/hisi/usb/hisi_hikey_gpio.h
 create mode 100644 include/linux/hisi/usb/hisi_usb.h

-- 
2.11.GIT

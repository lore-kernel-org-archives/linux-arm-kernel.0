From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Mon, 23 Apr 2018 19:23:52 +0100
Subject: [GIT PULL REQUEST v2] brcm: add fmac nvram files
Message-ID: <1524507832-19288-1-git-send-email-ryan.harkin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murata has created a github project for the firmware for their 43xx
family of devices:

  https://github.com/murata-wireless

This project contains firmware binaries for their WiFi and BT parts
containing the Cypress IP.

The binary files are licensed under the same LICENCE.cypress as present
in this repo already. The NVRAM files are text and are licensed under
GPLv2.

This series copies the files from the github project into
linux-firmware where other downstream projects may benefit.

v1->v2:
Hans de Goede:
 - rename generic .txt files to have ".generic" in their filename.
 - add a warning to the top of the .txt files

Ryan Harkin:
 - removed a comment about the "murata-master" folder from README_NVRAM
   that only applies to the original Murata github repo

----------------------------------------------------------------
The following changes since commit b562d2f3583f19ecda22b08e514ced57dd1e5f4d:

  linux-firmware: update wil6210 firmware to 5.2.0.18 (2018-04-16 09:55:50 -0400)

are available in the git repository at:

  https://git.linaro.org/landing-teams/working/mbl/linux-firmware.git 

for you to fetch changes up to 96f197a7ef8865e44ea8b8e4c1626e6a8c5e715f:

  cyw_bt: add Cypress 43xx Bluetooth patch files (2018-04-23 19:11:33 +0100)

Ryan Harkin (3):
      brcm: update firmware from Murata repo
      brcm: add fmac nvram files
      cyw_bt: add Cypress 43xx Bluetooth patch files

 WHENCE                              |  57 ++++++++++++--
 brcm/README_NVRAM                   |  15 ++++
 brcm/brcmfmac43012-sdio.1LV.txt     | 125 +++++++++++++++++++++++++++++
 brcm/brcmfmac43012-sdio.bin         | Bin 0 -> 210254 bytes
 brcm/brcmfmac43012-sdio.clm_blob    | Bin 0 -> 7697 bytes
 brcm/brcmfmac43012-sdio.generic.txt |   1 +
 brcm/brcmfmac43340-sdio.1BW.txt     | 127 ++++++++++++++++++++++++++++++
 brcm/brcmfmac43340-sdio.bin         | Bin 402210 -> 400864 bytes
 brcm/brcmfmac43340-sdio.generic.txt |   1 +
 brcm/brcmfmac43362-sdio.SN8000.txt  |  54 +++++++++++++
 brcm/brcmfmac43362-sdio.bin         | Bin 219557 -> 201276 bytes
 brcm/brcmfmac43362-sdio.generic.txt |   1 +
 brcm/brcmfmac4339-sdio.1CK.txt      | 110 ++++++++++++++++++++++++++
 brcm/brcmfmac4339-sdio.ZP.txt       | 107 +++++++++++++++++++++++++
 brcm/brcmfmac4339-sdio.bin          | Bin 562183 -> 565481 bytes
 brcm/brcmfmac4339-sdio.generic.txt  |   1 +
 brcm/brcmfmac43430-sdio.1DX.txt     |  48 ++++++++++++
 brcm/brcmfmac43430-sdio.1LN.txt     |   1 +
 brcm/brcmfmac43430-sdio.bin         | Bin 369577 -> 388739 bytes
 brcm/brcmfmac43430-sdio.generic.txt |   1 +
 brcm/brcmfmac43455-sdio.1HK.txt     | 126 ++++++++++++++++++++++++++++++
 brcm/brcmfmac43455-sdio.1LC.txt     |  78 ++++++++++++++++++
 brcm/brcmfmac43455-sdio.1MW.txt     | 119 ++++++++++++++++++++++++++++
 brcm/brcmfmac43455-sdio.bin         | Bin 488193 -> 594969 bytes
 brcm/brcmfmac43455-sdio.clm_blob    | Bin 0 -> 11913 bytes
 brcm/brcmfmac43455-sdio.generic.txt |   1 +
 brcm/brcmfmac4354-sdio.1BB.txt      | 145 ++++++++++++++++++++++++++++++++++
 brcm/brcmfmac4354-sdio.bin          | Bin 626589 -> 605388 bytes
 brcm/brcmfmac4354-sdio.generic.txt  |   1 +
 brcm/brcmfmac4356-pcie.1CX.txt      | 152 ++++++++++++++++++++++++++++++++++++
 brcm/brcmfmac4356-pcie.bin          | Bin 661999 -> 648770 bytes
 brcm/brcmfmac4356-pcie.generic.txt  |   1 +
 cyw_bt/CYW43012C0.1LV.hcd           | Bin 0 -> 28063 bytes
 cyw_bt/CYW43341B0.1BW.hcd           | Bin 0 -> 40984 bytes
 cyw_bt/CYW4335C0.ZP.hcd             | Bin 0 -> 33465 bytes
 cyw_bt/CYW43430A1.1DX.1dB_Less.hcd  | Bin 0 -> 35322 bytes
 cyw_bt/CYW43430A1.1DX.2dB_Less.hcd  | Bin 0 -> 35322 bytes
 cyw_bt/CYW43430A1.1DX.hcd           | Bin 0 -> 14265 bytes
 cyw_bt/CYW4345C0.1MW.hcd            | Bin 0 -> 55105 bytes
 cyw_bt/CYW4350C0.1BB.hcd            | Bin 0 -> 78697 bytes
 cyw_bt/CYW4354A2.1CX.hcd            | Bin 0 -> 31178 bytes
 41 files changed, 1265 insertions(+), 7 deletions(-)
 create mode 100644 brcm/README_NVRAM
 create mode 100644 brcm/brcmfmac43012-sdio.1LV.txt
 create mode 100644 brcm/brcmfmac43012-sdio.bin
 create mode 100644 brcm/brcmfmac43012-sdio.clm_blob
 create mode 120000 brcm/brcmfmac43012-sdio.generic.txt
 create mode 100644 brcm/brcmfmac43340-sdio.1BW.txt
 create mode 120000 brcm/brcmfmac43340-sdio.generic.txt
 create mode 100644 brcm/brcmfmac43362-sdio.SN8000.txt
 create mode 120000 brcm/brcmfmac43362-sdio.generic.txt
 create mode 100644 brcm/brcmfmac4339-sdio.1CK.txt
 create mode 100644 brcm/brcmfmac4339-sdio.ZP.txt
 create mode 120000 brcm/brcmfmac4339-sdio.generic.txt
 create mode 100644 brcm/brcmfmac43430-sdio.1DX.txt
 create mode 120000 brcm/brcmfmac43430-sdio.1LN.txt
 create mode 120000 brcm/brcmfmac43430-sdio.generic.txt
 create mode 100644 brcm/brcmfmac43455-sdio.1HK.txt
 create mode 100644 brcm/brcmfmac43455-sdio.1LC.txt
 create mode 100644 brcm/brcmfmac43455-sdio.1MW.txt
 create mode 100644 brcm/brcmfmac43455-sdio.clm_blob
 create mode 120000 brcm/brcmfmac43455-sdio.generic.txt
 create mode 100644 brcm/brcmfmac4354-sdio.1BB.txt
 create mode 120000 brcm/brcmfmac4354-sdio.generic.txt
 create mode 100644 brcm/brcmfmac4356-pcie.1CX.txt
 create mode 120000 brcm/brcmfmac4356-pcie.generic.txt
 create mode 100644 cyw_bt/CYW43012C0.1LV.hcd
 create mode 100644 cyw_bt/CYW43341B0.1BW.hcd
 create mode 100644 cyw_bt/CYW4335C0.ZP.hcd
 create mode 100644 cyw_bt/CYW43430A1.1DX.1dB_Less.hcd
 create mode 100644 cyw_bt/CYW43430A1.1DX.2dB_Less.hcd
 create mode 100644 cyw_bt/CYW43430A1.1DX.hcd
 create mode 100644 cyw_bt/CYW4345C0.1MW.hcd
 create mode 100644 cyw_bt/CYW4350C0.1BB.hcd
 create mode 100644 cyw_bt/CYW4354A2.1CX.hcd

From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Nov 2013 09:29:11 +0000
Subject: [PATCH 0/4] mfd: rtsx: Decrease driver size and add new device
Message-ID: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent added support request of yet another device, the burden
of duplicated Ops and Voltage Switch code was becoming a little messy.
To rectify is, we're creating a generic initialisation call, which in
turn uses a generic Ops structure. The individual initialisation routines
fill in the small differences in call-backs and device data after
invoking the generic call.

 drivers/mfd/rtl8411.c        | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 drivers/mfd/rtsx_pcr.c       |   8 ++++++-
 drivers/mfd/rtsx_pcr.h       |   1 +
 include/linux/mfd/rtsx_pci.h |   1 +
 4 files changed, 81 insertions(+), 73 deletions(-)

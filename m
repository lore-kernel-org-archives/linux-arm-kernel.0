From: niej0001@gmail.com (Jun Nie)
Date: Mon, 16 Nov 2009 17:33:58 +0800
Subject: [PATCH 0/8] enable pxa168 LCD on two platform
Message-ID: <7c34ac520911160133i47cfe4ectdcf8004204b51b3e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This the v3 of the serial patches, it add LCD controller SPI support
and enable frame
buffer on two platform. Several small fix are included. Comments from
Russell and Eric are merged. Thank you!


 arch/arm/configs/pxa168_defconfig       |   86 ++++++++++++++-
 arch/arm/configs/pxa910_defconfig       |   39 +++++++-
 arch/arm/mach-mmp/aspenite.c            |  182 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
 arch/arm/mach-mmp/include/mach/pxa910.h |    8 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |  144 ++++++++++++++++++++++++
 drivers/gpio/pca953x.c                  |    1 +
 drivers/video/pxa168fb.c                |  105 ++++++++++++++++++
 drivers/video/pxa168fb.h                |   24 +----
 include/video/pxa168fb.h                |   52 +++++++++-
 12 files changed, 628 insertions(+), 28 deletions(-)

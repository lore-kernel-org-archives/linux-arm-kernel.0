From: niej0001@gmail.com (Jun Nie)
Date: Tue, 10 Nov 2009 16:11:56 +0800
Subject: [PATCH 0/8] enable pxa168 LCD on two platform
Message-ID: <7c34ac520911100011x60a354b0mf2e27e1c5fd0422@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serial patches add LCD controller SPI support and enable frame
buffer on two platform. Several small fix are included.
comments from Eric and Russell are addressed.


 arch/arm/configs/pxa168_defconfig       |   86 +++++++++++++++-
 arch/arm/configs/pxa910_defconfig       |   39 +++++++-
 arch/arm/mach-mmp/aspenite.c            |  176 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
 arch/arm/mach-mmp/include/mach/pxa910.h |    8 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |  140 ++++++++++++++++++++++++
 drivers/gpio/pca953x.c                  |    1 +
 drivers/video/pxa168fb.c                |  102 ++++++++++++++++++
 drivers/video/pxa168fb.h                |   24 +----
 include/video/pxa168fb.h                |   49 ++++++++-
 12 files changed, 612 insertions(+), 28 deletions(-)

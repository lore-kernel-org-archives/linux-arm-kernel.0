From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 31 May 2010 13:58:21 +0200
Subject: [PATCH 0/3] ARM: S3C64XX: DMA core patches
Message-ID: <4C03A45D.1050802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first two patches add support for SDMA to the DMA core, which the crypto
engine needs to support DMA.

The third one implements behaviour that seems to be forgotten, namely stopping
and flushing pending requests on freeing a DMA channel.

Maurus Cuelenaere (3):
  ARM: S3C64XX: Add SDMA clocks
  ARM: S3C64XX: Add SDMA support to DMA core
  ARM: S3C64XX: Stop and flush requests on freeing

 arch/arm/mach-s3c64xx/clock.c |   12 +++++++++
 arch/arm/mach-s3c64xx/dma.c   |   55 ++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 12 deletions(-)

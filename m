From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Wed, 09 Nov 2011 17:34:46 -0800
Subject: [PATCH] spi: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1320887221-7165-1-git-send-email-harinij@codeaurora.org>
References: <y> <1320887221-7165-1-git-send-email-harinij@codeaurora.org>
Message-ID: <4EBB2A36.9040609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2011 05:07 PM, Harini Jayaraman wrote:
> This bus driver supports the QUP SPI hardware controller in the Qualcomm
> MSM SOCs. The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded SPI
> mini-core. The driver currently supports only FIFO mode.
> 
> Signed-off-by: Harini Jayaraman <harinij@codeaurora.org>
> ---
>  drivers/spi/Kconfig                   |   10 +
>  drivers/spi/Makefile                  |    1 +
>  drivers/spi/msm_spi_qsd.h             |  436 +++++++++++++
>  drivers/spi/spi-qsd.c                 | 1144 +++++++++++++++++++++++++++++++++
>  include/linux/platform_data/msm_spi.h |   19 +
>  5 files changed, 1610 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/msm_spi_qsd.h
>  create mode 100644 drivers/spi/spi-qsd.c
>  create mode 100644 include/linux/platform_data/msm_spi.h

A few high-level comments to start.  Let's drop 'qsd' from all the
names.  We haven't used that naming convention for several years now.
Better to just call this 'spi-qup.[ch]'.  Also, please update the
copyright dates.  This driver existed before 2011.  Thanks.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

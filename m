From: kheitke@codeaurora.org (Kenneth Heitke)
Date: Wed, 14 Sep 2011 12:39:53 -0600
Subject: [PATCH v2] i2c: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1308018114-19709-1-git-send-email-kheitke@codeaurora.org>
References: <1308018114-19709-1-git-send-email-kheitke@codeaurora.org>
Message-ID: <4E70F4F9.2000707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2011 08:21 PM, Kenneth Heitke wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm
> MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded i2c
> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.
>
> Signed-off-by: Kenneth Heitke<kheitke@codeaurora.org>
> ---
> v2: updates to runtime PM calls (addresses comments from Mark Brown).
>      Disable interrupts before setting completion object to NULL (bug fix).
> ---
>   drivers/i2c/busses/Kconfig                |   11 +
>   drivers/i2c/busses/Makefile               |    1 +
>   drivers/i2c/busses/i2c-qup.c              | 1175 +++++++++++++++++++++++++++++
>   include/linux/platform_data/msm_qup_i2c.h |   24 +
>   4 files changed, 1211 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/i2c/busses/i2c-qup.c
>   create mode 100644 include/linux/platform_data/msm_qup_i2c.h
>

Hi Ben,

Would it be possible to pull this driver into your tree?  If not, please 
let me know of any concerns that need to be addresses.

thanks,
Ken


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

From: evgreen@chromium.org (Evan Green)
Date: Thu, 17 May 2018 15:30:53 -0700
Subject: [PATCH v7 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
References: <1526492623-20527-1-git-send-email-rishabhb@codeaurora.org>
 <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
Message-ID: <CAE=gft77E+nuRuXxnSFt4bttLVaKiRgH=dvwu=Q9cO4Ga9TN8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 10:44 AM Rishabh Bhatnagar <rishabhb@codeaurora.org>
wrote:

> LLCC (Last Level Cache Controller) provides additional cache memory
> in the system. LLCC is partitioned into multiple slices and each
> slice gets its own priority, size, ID and other config parameters.
> LLCC driver programs these parameters for each slice. Clients that
> are assigned to use LLCC need to get information such size & ID of the
> slice they get and activate or deactivate the slice as needed. LLCC driver
> provides API for the clients to perform these operations.

> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>   drivers/soc/qcom/Kconfig           |  17 ++
>   drivers/soc/qcom/Makefile          |   2 +
>   drivers/soc/qcom/llcc-sdm845.c     | 106 ++++++++++++
>   drivers/soc/qcom/llcc-slice.c      | 337
+++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 180 ++++++++++++++++++++
>   5 files changed, 642 insertions(+)
>   create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>   create mode 100644 drivers/soc/qcom/llcc-slice.c
>   create mode 100644 include/linux/soc/qcom/llcc-qcom.h


Thanks Rishabh.

Reviewed-by: Evan Green <evgreen@chromium.org>

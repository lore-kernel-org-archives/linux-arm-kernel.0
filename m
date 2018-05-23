From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 May 2018 14:51:29 +0100
Subject: [PATCH v11 1/8] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <1527079981-11179-2-git-send-email-ilialin@codeaurora.org>
References: <1527079981-11179-1-git-send-email-ilialin@codeaurora.org>
 <1527079981-11179-2-git-send-email-ilialin@codeaurora.org>
Message-ID: <1cd8b060-9dec-6dce-cb57-4a43bf441f12@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/05/18 13:52, Ilia Lin wrote:
> The driver provides kernel level API for other drivers
> to access the MSM8996 L2 cache registers.
> Separating the L2 access code from the PMU driver and
> making it public to allow other drivers use it.
> The accesses must be separated with a single spinlock,
> maintained in this driver.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/perf/Kconfig                 |  1 +
>  drivers/perf/qcom_l2_pmu.c           | 90 ++++++++++--------------------------
>  drivers/soc/qcom/Kconfig             |  3 ++
>  drivers/soc/qcom/Makefile            |  1 +
>  drivers/soc/qcom/kryo-l2-accessors.c | 56 ++++++++++++++++++++++
>  include/soc/qcom/kryo-l2-accessors.h | 12 +++++
>  6 files changed, 97 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
>  create mode 100644 include/soc/qcom/kryo-l2-accessors.h
> 

[..
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 7093fe7..0567dff 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -39,6 +39,9 @@ config QCOM_GSBI
>            functions for connecting the underlying serial UART, SPI, and I2C
>            devices to the output pins.
>  
> +config QCOM_KRYO_L2_ACCESSORS
> +       bool
> +

I think kbuild bot complained about this and you haven't addressed it.
This can be enabled on ARM and build breaks due to missing sysreg.h
IIRC. Look at the kbuild report and fix it.

-- 
Regards,
Sudeep

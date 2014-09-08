From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Mon, 08 Sep 2014 15:18:54 +0530
Subject: [PATCH v5 2/7] qcom: spm: Add Subsystem Power Manager driver
 (SAW2)
In-Reply-To: <1409870132-16929-3-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
 <1409870132-16929-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <540D7B86.1000008@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

On Friday 05 September 2014 04:05 AM, Lina Iyer wrote:

>  drivers/soc/qcom/spm.c     | 192 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/soc/qcom/spm-drv.h
>  create mode 100644 drivers/soc/qcom/spm.c
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d52ed..20b329f 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
> +obj-$(CONFIG_QCOM_PM)	+=	spm.o

CONFIG_QCOM_PM is missing in Kconfig hence this driver wont build. I see
it is added in patch #3. Please move it to this patch so that this
driver builds.

>  CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
>  obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
> diff --git a/drivers/soc/qcom/spm-drv.h b/drivers/soc/qcom/spm-drv.h
> new file mode 100644
> index 0000000..e91df44

Thanks
Pramod

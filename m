From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jun 2016 23:05:25 +0200
Subject: [PATCH v3 2/2] remoteproc: qcom: Introduce WCNSS peripheral image
 loader
In-Reply-To: <1467147506-753-2-git-send-email-bjorn.andersson@linaro.org>
References: <1467147506-753-1-git-send-email-bjorn.andersson@linaro.org>
 <1467147506-753-2-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <115043528.GxNIb9dTCg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 28, 2016 1:58:26 PM CEST Bjorn Andersson wrote:
> 
> +config QCOM_WCNSS_PIL
> +       tristate "Qualcomm WCNSS Peripheral Image Loader"
> +       depends on OF && ARCH_QCOM
> +       select QCOM_MDT_LOADER
> +       select QCOM_SCM
> +       select REMOTEPROC
> +       help
> +         Say y here to support the Peripherial Image Loader for the Qualcomm
> +         Wireless Connectivity Subsystem.
> +
> 

	"depends on QCOM_SMEM"

This showed up in Linux-next today and caused a build error:

drivers/remoteproc/built-in.o: In function `q6v5_fatal_interrupt':
qcom_q6v5_pil.c:(.text+0x2428): undefined reference to `qcom_smem_get'
drivers/remoteproc/built-in.o: In function `q6v5_wdog_interrupt':
qcom_q6v5_pil.c:(.text+0x2498): undefined reference to `qcom_smem_get'


	Arnd

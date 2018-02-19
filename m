From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 21:08:19 -0600
Subject: [PATCH v3 02/25] soc: qcom: add support to APR bus driver
In-Reply-To: <20180213165837.1620-3-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-3-srinivas.kandagatla@linaro.org>
Message-ID: <20180219030819.qovj4swuvged6c24@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:14PM +0000, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/apr.c             | 381 +++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,apr.h |  27 +++

This belongs in the binding patch.

>  include/linux/mod_devicetable.h    |  11 ++
>  include/linux/soc/qcom/apr.h       | 131 +++++++++++++
>  6 files changed, 560 insertions(+)
>  create mode 100644 drivers/soc/qcom/apr.c
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h
>  create mode 100644 include/linux/soc/qcom/apr.h


> diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
> new file mode 100644
> index 000000000000..fb162ac4ca0e
> --- /dev/null
> +++ b/include/dt-bindings/soc/qcom,apr.h
> @@ -0,0 +1,27 @@

SPDX tag

> +#ifndef __DT_BINDINGS_QCOM_APR_H
> +#define __DT_BINDINGS_QCOM_APR_H
> +
> +/* Domain IDs */
> +#define APR_DOMAIN_SIM	0x1
> +#define APR_DOMAIN_PC	0x2
> +#define APR_DOMAIN_MODEM 0x3
> +#define APR_DOMAIN_ADSP	0x4
> +#define APR_DOMAIN_APPS	0x5
> +#define APR_DOMAIN_MAX	0x6
> +
> +/* ADSP service IDs */
> +#define APR_SVC_ADSP_CORE	0x3
> +#define APR_SVC_AFE		0x4
> +#define APR_SVC_VSM		0x5
> +#define APR_SVC_VPM		0x6
> +#define APR_SVC_ASM		0x7
> +#define APR_SVC_ADM		0x8
> +#define APR_SVC_ADSP_MVM	0x09
> +#define APR_SVC_ADSP_CVS	0x0A
> +#define APR_SVC_ADSP_CVP	0x0B
> +#define APR_SVC_USM		0x0C
> +#define APR_SVC_LSM		0x0D
> +#define APR_SVC_VIDC		0x16
> +#define APR_SVC_MAX		0x17
> +
> +#endif /* __DT_BINDINGS_QCOM_APR_H */

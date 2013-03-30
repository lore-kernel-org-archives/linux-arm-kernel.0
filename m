From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Mar 2013 12:52:39 -0300
Subject: PCI support for IMX6
In-Reply-To: <20130330113703.GA21042@amd.pavel.ucw.cz>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
Message-ID: <CAOMZO5Df3wFhT=Mbpct1nR1UrZWSq9_emfTp8i2imJaWoLmfEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 8:37 AM, Pavel Machek <pavel@ucw.cz> wrote:

> +#define SBC6X_PCIE_PWR                  IMX_GPIO_NR(1, 3)
> +#define SBC6X_PCIE_RST                  IMX_GPIO_NR(1, 8)

These pins need to be programmed as GPIO in the dts file.

> +
> +#include "pcie.h"
> +struct imx_pcie_data {
> +        int id;
> +        resource_size_t iobase;
> +        resource_size_t iosize;
> +       resource_size_t irq;
> +};
> +
> +struct platform_device *__init imx_add_pcie(
> +       const struct imx_pcie_data *data,
> +       const struct imx_pcie_platform_data *pdata);
> +
> +static const struct imx_pcie_platform_data mx6_sbc6x_pcie_data __initconst = {
> +        .pcie_pwr_en    =  SBC6X_PCIE_PWR,
> +        .pcie_rst       =  SBC6X_PCIE_RST,
> +        .pcie_wake_up   = -EINVAL,
> +        .pcie_dis       = -EINVAL,

mx6 has been converted to devide tree, so you should not be passing
platform data here.

These PCI related GPIOs should be passed via dts and the driver should
be able to parse them.

Regards,

Fabio Estevam

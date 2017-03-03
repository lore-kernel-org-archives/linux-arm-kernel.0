From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 3 Mar 2017 09:50:02 +0000
Subject: [PATCH 1/2] nvmem: Add driver for the i.MX IIM
In-Reply-To: <20170213153149.11710-2-s.hauer@pengutronix.de>
References: <20170213153149.11710-1-s.hauer@pengutronix.de>
 <20170213153149.11710-2-s.hauer@pengutronix.de>
Message-ID: <568bbe58-0bb5-f7ec-a646-271912a4313a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/02/17 15:31, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
> This adds a readonly nvmem driver for the i.MX IC Identification Module
> (IIM). The IIM is found on the older i.MX SoCs like the i.MX25, i.MX27,
> i.MX31, i.MX35, i.MX51 and the i.MX53.
>
> The IIM can control up to 8 fuse banks with 256 bit each. Not all of the
> banks are equipped on the different SoCs. The actual number of fuses
> differ from 512 on the i.MX27 and 1152 on the i.MX53.
>
> The fuses are one time writable, but writing is currently not supported
> in the driver.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  drivers/nvmem/Kconfig   |  11 ++++
>  drivers/nvmem/Makefile  |   2 +
>  drivers/nvmem/imx-iim.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 184 insertions(+)
>  create mode 100644 drivers/nvmem/imx-iim.c

Patch looks good to me, Will pick both bindings and this patch in next 
cycle for 4.12.

thanks,
srini

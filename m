From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Sep 2011 07:36:41 -0300
Subject: [V8 PATCH 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
In-Reply-To: <1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
References: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
	<1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
Message-ID: <CAOMZO5CRB_tXYw1-B+LPKPAaEdTaMUbG2zT3m+UF3vp_6m+2=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 7:14 AM, Richard Zhu <richard.zhu@linaro.org> wrote:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
> ?arch/arm/mach-mx5/board-mx53_smd.c | ? 16 ++++++++++++++++
> ?1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
> index bc02894..9d06fbe 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -35,6 +35,7 @@
> ?#include "devices-imx53.h"
>
> ?#define SMD_FEC_PHY_RST ? ? ? ? ? ? ? ?IMX_GPIO_NR(7, 6)
> +#define MX53_SMD_SATA_PWR_EN ? ?IMX_GPIO_NR(3, 3)
>
> ?static iomux_v3_cfg_t mx53_smd_pads[] = {
> ? ? ? ?MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
> @@ -111,6 +112,19 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
> ? ? ? ?.bitrate = 100000,
> ?};
>
> +static inline void mx53_smd_ahci_pwr_on(void)
> +{
> + ? ? ? int ret;
> +
> + ? ? ? /* Enable SATA PWR */
> + ? ? ? ret = gpio_request(MX53_SMD_SATA_PWR_EN, "ahci-sata-pwr");

Please use gpio_request_one.

> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "failed to get SATA_PWR_EN: %d\n", ret);

You can use pr_err instead.

Regards,

Fabio Estevam

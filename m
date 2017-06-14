From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 17:03:26 -0700
Subject: [PATCH v2 2/2] soc: brcmstb: Add driver for DPFE
In-Reply-To: <20170613223710.31719-3-code@mmayer.net>
References: <20170613223710.31719-1-code@mmayer.net>
 <20170613223710.31719-3-code@mmayer.net>
Message-ID: <5b79dee6-bb84-30b3-1bb2-287b24d42534@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 06/13/2017 03:37 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This driver allows access to DRAM properties, such as the refresh rate,
> via the Broadcom STB DDR PHY Front End (DPFE). The refresh rate can be
> used as indirect indicator of the DRAM temperature.
> 
> The driver also allows setting of the sampling interval.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  MAINTAINERS                      |   8 +
>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>  drivers/soc/bcm/brcmstb/dpfe.c   | 689 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 698 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/bcm/brcmstb/dpfe.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7d568b..04f0be6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2864,6 +2864,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
>  F:	drivers/cpufreq/brcmstb*
>  
> +BROADCOM STB SOC DPFE DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +M:	bcm-kernel-feedback-list at broadcom.com
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
> +F:	drivers/misc/brcmstb-dpfe.c

Just one nit: this should be drivers/soc/bcm/brcmstb/dpfe.c, other than
that, I just need an Ack from Rob on the binding, and I will queue this
up, thanks!
-- 
Florian

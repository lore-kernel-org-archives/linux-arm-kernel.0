From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 04 Apr 2011 22:35:42 +0400
Subject: [PATCH v4 1/4] davinci: da8xx: add spi resources and registration
	routine
In-Reply-To: <1298486651-18882-2-git-send-email-michael.williamson@criticallink.com>
References: <1298486651-18882-1-git-send-email-michael.williamson@criticallink.com>
	<1298486651-18882-2-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D9A0F7E.1050606@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson wrote:

> Add IO resource structures, platform data, and a registration
> routine in order to support spi device on DA850/OMAP-L138/AM18x
> and DA830/OMAP-L137/AM17x platforms.

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
>  arch/arm/mach-davinci/devices-da8xx.c      |  104 ++++++++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/da8xx.h |    4 +
>  2 files changed, 108 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 119d46e..625d4b6 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -38,14 +38,20 @@
>  #define DA8XX_EMAC_MDIO_BASE		0x01e24000
>  #define DA8XX_GPIO_BASE			0x01e26000
>  #define DA8XX_I2C1_BASE			0x01e28000
> +#define DA8XX_SPI0_BASE			0x01c41000
> +#define DA8XX_SPI1_BASE			0x01f0e000

    Unfortunately, DA830 and DA850 have SPI#1 mapped at different addresses, so 
this will work only on DA850. I'll send a patch...

WBR, Sergei

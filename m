From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 05 Oct 2009 08:33:26 +1300
Subject: [PATCH v1.0 3/4] EP93XX: Add more register definition
In-Reply-To: <20091004011429.12578.27177.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<20091004011429.12578.27177.stgit@localhost.localdomain>
Message-ID: <4AC8F886.2050806@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> Add register definition for GPIO A,B,C and D data and data direction,
> Security, Chip ID, ...
> 
> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
> ---
> 
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index c5216fc..a5f721e 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -111,28 +111,42 @@
>  #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
>  
>  #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
> +#define EP93XX_SECURITY_REG(x)		(EP93XX_SECURITY_BASE + (x))
> +#define EP93XX_SECURITY_UNIQID		EP93XX_SECURITY_REG(0x2440)
>  
>  #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
>  #define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
> +#define EP93XX_GPIO_A_DATA		EP93XX_GPIO_REG(0x00)
> +#define EP93XX_GPIO_B_DATA		EP93XX_GPIO_REG(0x04)
> +#define EP93XX_GPIO_C_DATA		EP93XX_GPIO_REG(0x08)
> +#define EP93XX_GPIO_D_DATA		EP93XX_GPIO_REG(0x0C)
> +#define EP93XX_GPIO_A_DIR		EP93XX_GPIO_REG(0x10)
> +#define EP93XX_GPIO_B_DIR		EP93XX_GPIO_REG(0x14)
> +#define EP93XX_GPIO_C_DIR		EP93XX_GPIO_REG(0x18)
> +#define EP93XX_GPIO_D_DIR		EP93XX_GPIO_REG(0x1C)

Are these being used for something? EP93xx already has full gpiolib
support, so there should be no need to define these registers.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

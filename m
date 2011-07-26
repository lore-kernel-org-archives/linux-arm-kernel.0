From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 09:00:52 +0100
Subject: [PATCH V2 5/7] ARM: S5P64X0: Add file to hold common
	Framebuffer and LCD code
In-Reply-To: <1311624025-2643-6-git-send-email-ajaykumar.rs@samsung.com>
References: <1311624025-2643-1-git-send-email-ajaykumar.rs@samsung.com>
	<1311624025-2643-6-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <20110726080052.GM9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 04:00:23PM -0400, Ajay Kumar wrote:
> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
> index 4fee745..ed87151 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -32,6 +32,11 @@ config S5P64X0_SETUP_I2C1
>  	help
>  	  Common setup code for i2c bus 1.
>  
> +config COMMON_FB

This is a very bad config name.  It's specific to a group of SoCs but it
seems to be advertising itself as something which isn't.  What if
drivers/video/Kconfig gets a COMMON_FB symbol too?

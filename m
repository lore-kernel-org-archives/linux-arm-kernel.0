From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 07 Nov 2013 04:11:02 -0600
Subject: [PATCHv2] arm: socfpga: Enable ARM_TWD for socfpga
In-Reply-To: <1380655870-19040-1-git-send-email-dinguyen@altera.com>
References: <1380655870-19040-1-git-send-email-dinguyen@altera.com>
Message-ID: <527B6736.6090406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

On 10/1/13 2:31 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> Update SOCFPGA's Kconfig to include building the ARM TWD timer for
> SMP use.
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> v2:
> - Add a condition 'if SMP' for HAVE_ARM_TWD
> ---
>  arch/arm/mach-socfpga/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index dd86db4..823de65 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -11,6 +11,7 @@ config ARCH_SOCFPGA
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_PL061 if GPIOLIB
>  	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select MFD_SYSCON
>  	select SPARSE_IRQ

If it's not too late, can you apply this?

Thanks,
DInh

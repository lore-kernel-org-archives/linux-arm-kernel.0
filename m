From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 09:40:31 +0900
Subject: [PATCH 1/6] ARM: s3c24xx: don't select EEPROM_AT24
In-Reply-To: <1454079040-3567945-2-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-2-git-send-email-arnd@arndb.de>
Message-ID: <56AEA97F.80206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> EEPROM_AT24 depends on both I2C and SYSFS. We have in the past
> added I2C 'select' statements to avoid build problems with the
> first, but we still get a warning because of the second:
> 
> warning: (MACH_DAVINCI_EVM && MACH_SFFSDR && MACH_DAVINCI_DM6467_EVM && MACH_DAVINCI_DM365_EVM && MACH_DAVINCI_DA830_EVM && MACH_MITYOMAPL138 && MACH_MINI2440) selects EEPROM_AT24 which has unmet direct dependencies (I2C && SYSFS)
> 
> This removes the 'select' statements again, and forces users to
> enable the driver in their configuration files, as we do for
> most other drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/mini2440_defconfig | 1 +
>  arch/arm/configs/s3c2410_defconfig  | 1 +
>  arch/arm/mach-s3c24xx/Kconfig       | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

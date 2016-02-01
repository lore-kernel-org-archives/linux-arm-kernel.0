From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 09:46:11 +0900
Subject: [PATCH 2/6] ARM: s3c24xx: allow selecting S3C2440_XTAL_16934400
 for s3c2442
In-Reply-To: <1454079040-3567945-3-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-3-git-send-email-arnd@arndb.de>
Message-ID: <56AEAAD3.1060501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> The S3C2440_XTAL_16934400 and S3C2440_XTAL_12000000 symbols are used
> for both s3c2442 and s3c2440, but Kconfig only allows it to be selected
> if CPU_S3C2440 is enabled, which can lead to a warning otherwise:
> 
> warning: (MACH_RX1950) selects S3C2440_XTAL_16934400 which has unmet direct dependencies (ARCH_S3C24XX && CPU_S3C2440)
> 
> This changes the dependencies to make it possible also for CPU_S3C2442-only
> configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

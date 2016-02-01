From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 09:49:08 +0900
Subject: [PATCH 3/6] ARM: s3c24xx: fix unused
 gta02_configure_pmu_for_charger warning
In-Reply-To: <1454079040-3567945-4-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-4-git-send-email-arnd@arndb.de>
Message-ID: <56AEAB84.8080305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> gta02_configure_pmu_for_charger is only used when CONFIG_PCF50633_ADC
> is set, and otherwise we get a warning about an unused symbol:
> 
> arch/arm/mach-s3c24xx/mach-gta02.c:158:1: warning: 'gta02_configure_pmu_for_charger' defined but not used [-Wunused-function]
>  gta02_configure_pmu_for_charger(struct pcf50633 *pcf, void *unused, int res)
> 
> This adds an #ifdef to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/mach-gta02.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 10:18:59 +0900
Subject: [PATCH 5/6] ARM: s3c64xx: mark regulator init data as unused
In-Reply-To: <1454079040-3567945-6-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-6-git-send-email-arnd@arndb.de>
Message-ID: <56AEB283.5040101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> The smdk6410 board defines lots of regulator settings, but uses
> most of them only in certain configurations, and otherwise leaves
> them without any references, so we get lots of randconfig warnings
> about them:
> 
> mach-s3c64xx/mach-smdk6410.c:303:35: error: 'smdk6410_vddarm' defined but not used [-Werror=unused-variable]
> mach-s3c64xx/mach-smdk6410.c:316:35: error: 'smdk6410_vddint' defined but not used [-Werror=unused-variable]
> mach-s3c64xx/mach-smdk6410.c:327:35: error: 'smdk6410_vddhi' defined but not used [-Werror=unused-variable]
> mach-s3c64xx/mach-smdk6410.c:335:35: error: 'smdk6410_vddpll' defined but not used [-Werror=unused-variable]
> mach-s3c64xx/mach-smdk6410.c:343:35: error: 'smdk6410_vdduh_mmc' defined but not used [-Werror=unused-variable]
> 
> This marks all regulator_init_data structures in this file as
> __maybe_unused, indicating that we don't care whether there
> are any references or not in a given configuration.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c | 38 +++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

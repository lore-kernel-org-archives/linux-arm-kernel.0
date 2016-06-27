From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Jun 2016 13:33:51 +0200
Subject: [PATCH] ARM: s3c64xx: avoid warning about 'struct device_node'
In-Reply-To: <20160627110303.3391769-1-arnd@arndb.de>
References: <20160627110303.3391769-1-arnd@arndb.de>
Message-ID: <57710F1F.8090304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2016 01:02 PM, Arnd Bergmann wrote:
> The change to simplify of_platform_populate() had an unintended
> side-effect of introducing a build warning on s3c64xx:
> 
> In file included from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c:18:0:
> arch/arm/mach-s3c64xx/common.h:27:30: error: 'struct device_node' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> This adds a forward-declaration for the structure name in the
> header to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 850bea2335e4 ("arm: Remove unnecessary of_platform_populate with default match table")
> ---
> Rob, can you apply this on top of the devicetree git so we don't
> have to coordinate the merges?

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR,
Krzysztof

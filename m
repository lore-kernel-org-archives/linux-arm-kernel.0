From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 26 Jan 2016 13:09:01 +0900
Subject: [PATCH 2/2] ASoC: s3c24xx: use const snd_soc_component_driver
 pointer
In-Reply-To: <1453741678-1988125-2-git-send-email-arnd@arndb.de>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
 <1453741678-1988125-2-git-send-email-arnd@arndb.de>
Message-ID: <56A6F15D.3040504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.01.2016 02:07, Arnd Bergmann wrote:
> An older patch to convert the API in the s3c i2s driver
> ended up passing a const pointer into a function that takes
> a non-const pointer, so we now get a warning:
> 
> sound/soc/samsung/s3c2412-i2s.c: In function 's3c2412_iis_dev_probe':
> sound/soc/samsung/s3c2412-i2s.c:172:9: error: passing argument 3 of 's3c_i2sv2_register_component' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 
> However, the s3c_i2sv2_register_component() function again
> passes the pointer into another function taking a const, so
> we just need to change its prototype.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: eca3b01d0885 ("ASoC: switch over to use snd_soc_register_component() on s3c i2s")
> ---
>  sound/soc/samsung/s3c-i2s-v2.c | 2 +-
>  sound/soc/samsung/s3c-i2s-v2.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

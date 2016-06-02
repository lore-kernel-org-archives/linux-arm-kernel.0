From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 2 Jun 2016 09:52:07 -0400
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable s5p-secss driver
In-Reply-To: <1464846916-3110-3-git-send-email-k.kozlowski@samsung.com>
References: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
 <1464846916-3110-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <b3518170-bf5c-dde0-b170-68910a2aaf42@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/02/2016 01:55 AM, Krzysztof Kozlowski wrote:
> The Exynos SoC provides a Security SubSystem block for accelerating some
> cryptographic operations.  Enable the driver for it - s5p-secss to
> utilize the hardware acceleration.
> 
> Currently the s5p-secss driver supports AES in CBC and ECB modes.
> However its usefulness could be doubted. Excerpt of tests on Odroid XU3
> (Exynos5422), for 256 bit key, encryption, performance CPU freq governor:
> 
>   algorithm        | block size [b] | average speed [MB/s] |
>   cbc-aes-s5p      |             16 |                 11.5 |
>   cbc-aes-s5p      |             64 |                 25.4 |
>   cbc-aes-s5p      |            256 |                 41.0 |
>   cbc-aes-s5p      |           1024 |                 47.4 |
>   cbc-aes-s5p      |           8192 |                 49.0 |
>   cbc(aes-generic) |             16 |                  0.4 |
>   cbc(aes-generic) |             64 |                  1.8 |
>   cbc(aes-generic) |            256 |                  6.6 |
>   cbc(aes-generic) |           1024 |                 25.2 |
>   cbc(aes-generic) |           8192 |                 83.1 |
> 
> Anyway enable the driver so it will get some testing coverage by
> community.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

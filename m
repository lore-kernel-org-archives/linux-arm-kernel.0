From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 08 Dec 2015 09:38:46 +0900
Subject: [PATCH 04/23] mtd: nand: s3c2410: kill the ->ecc_layout field
In-Reply-To: <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56662696.1000705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.12.2015 07:25, Boris Brezillon wrote:
> The s3c2410 is allowing board data to overload the default ECC layout
> defined inside the driver, but this feature is not used by board
> specific definitions.
> Kill this field so that we can easily move to a model where ecclayout
> are dynamically allocated by the NAND controller driver.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/plat-samsung/devs.c                   | 9 ---------
>  drivers/mtd/nand/s3c2410.c                     | 3 ---
>  include/linux/platform_data/mtd-nand-s3c2410.h | 1 -
>  3 files changed, 13 deletions(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

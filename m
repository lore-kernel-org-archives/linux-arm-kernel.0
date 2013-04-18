From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 12:50:50 +0200
Subject: [PATCH 05/32] dmaengine: ste_dma40: Supply macros to resolve
 'src' and 'dst' directions
In-Reply-To: <1366279934-30761-6-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-6-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181250.50647.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> +#define D40_IS_SRC(dir)  ((dir == STEDMA40_PERIPH_TO_MEM) ? true : false)
> +#define D40_IS_DST(dir) (((dir == STEDMA40_MEM_TO_PERIPH) || \
> +                         (dir == STEDMA40_MEM_TO_MEM)) ? true : false)
> +

The redundant "? true : false" part is redundant. ;-)

Otherwise the patch looks good.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd

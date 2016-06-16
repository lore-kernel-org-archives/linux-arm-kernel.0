From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jun 2016 15:02:02 +0200
Subject: [PATCH 1/5] clk: max77686: Combine Maxim max77686 and max77802
 driver
In-Reply-To: <1466000018-16784-2-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <5762A34A.3060309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 04:13 PM, Laxman Dewangan wrote:
> The clock IP used on the Maxim PMICs max77686 and max77802 are
> same. The configuration of clock register is also same except
> the number of clocks.
> 
> Part of common code utilisation, there is 3 files for these chips
> clock driver, one for common and two files for driver registration.
> 
> Combine both drivers into single file and move common code into
> same common file reduces the 2 files and make max77686 and max77802
> clock driver in single fine. This driver does not depends on the
> parent driver structure. The regmap handle is acquired through
> regmap APIs for the register access.
> 
> This combination of driver helps on adding clock driver for different
> Maxim PMICs which has similar clock IP like MAX77620 and MAX20024.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  drivers/clk/Kconfig        |  15 +--
>  drivers/clk/Makefile       |   2 -
>  drivers/clk/clk-max-gen.c  | 194 ------------------------------------
>  drivers/clk/clk-max-gen.h  |  32 ------
>  drivers/clk/clk-max77686.c | 241 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/clk/clk-max77802.c |  96 ------------------
>  6 files changed, 225 insertions(+), 355 deletions(-)
>  delete mode 100644 drivers/clk/clk-max-gen.c
>  delete mode 100644 drivers/clk/clk-max-gen.h
>  delete mode 100644 drivers/clk/clk-max77802.c

Tested on max77686 and max77802:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Jul 2016 22:39:27 +0200
Subject: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
In-Reply-To: <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160708203927.GB26626@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:46:39PM +0900, Andi Shyti wrote:
> The new compatible is related to the Samsung Exynos5433 SoC. The
> difference between the previous is that in the exynos5433 the SPI
> controller is driven by three clocks instead of only one.
> 
> The new clock (ioclk) is controlling the input/output clock
> whenever the controller is slave or master.
> 
> The presence of the clock line is detected from the compatibility
> structure (exynos5433_spi_port_config) as a boolean value.
> 
> The probe function checks whether the ioclk is present and if so,
> it acquires.
> 
> The runtime suspend and resume functions will handle the clock
> enabling and disabling as well.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 5 deletions(-)
>

Looks fine to me, thanks for updates.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

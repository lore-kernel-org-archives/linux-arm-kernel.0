From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 29 Apr 2018 19:28:28 +0200
Subject: [PATCH 1/5] ARM: dts: exynos: Remove unnecessary address/size
 properties in Midas boards
In-Reply-To: <20180424174602.3915-1-krzk@kernel.org>
References: <20180424174602.3915-1-krzk@kernel.org>
Message-ID: <20180429172828.2j2qjuwl6z2oipup@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:45:58PM +0200, Krzysztof Kozlowski wrote:
> The children of regulators node do not have reg/ranges properties.  Move the
> children up one level, get rid of regulators node and remove
> address-cells and size-cells properties.  This fixes warnings for
> Exynos4412 Midas family boards:
> 
>     arch/arm/boot/dts/exynos4412-i9300.dtb: Warning (avoid_unnecessary_addr_size):
>         /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>     arch/arm/boot/dts/exynos4412-i9305.dtb: Warning (avoid_unnecessary_addr_size):
>         /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>     arch/arm/boot/dts/exynos4412-n710x.dtb: Warning (avoid_unnecessary_addr_size):
>         /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 32 +++++------
>  arch/arm/boot/dts/exynos4412-midas.dtsi     | 86 ++++++++++++++---------------
>  2 files changed, 55 insertions(+), 63 deletions(-)

Applied entire series.


Best regards,
Krzysztof

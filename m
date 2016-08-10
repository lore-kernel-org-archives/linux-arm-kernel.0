From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 10 Aug 2016 15:23:43 +0200
Subject: [RFT RESEND PATCH v3 3/3] ARM: select PCI_DOMAINS config from
 ARCH_MULTIPLATFORM
In-Reply-To: <1470832400-11929-4-git-send-email-kishon@ti.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-4-git-send-email-kishon@ti.com>
Message-ID: <cf4a7376-1cd4-aeb4-cbf0-7dbbc3575137@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 02:33 PM, Kishon Vijay Abraham I wrote:
> PCI_DOMAINS config should be selected for any SoCs
> having more than a single PCIe controller. Without PCI_DOMAINS
> config, only one PCIe controller gets registered.
> 
> Select PCI_DOMAINS in ARCH_MULTIPLATFORM if PCI is selected, since
> it doesn't harm even if a platform has a single PCIe port.
> Also remove PCI_DOMAINS being selected from other platform
> specific configs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/Kconfig               |    1 +
>  arch/arm/mach-axxia/Kconfig    |    1 -
>  arch/arm/mach-cns3xxx/Kconfig  |    1 -
>  arch/arm/mach-exynos/Kconfig   |    1 -
>  arch/arm/mach-imx/Kconfig      |    2 --
>  arch/arm/mach-keystone/Kconfig |    1 -
>  arch/arm/mach-shmobile/Kconfig |    1 -
>  7 files changed, 1 insertion(+), 7 deletions(-)

For Exynos5440 output is equal and we do not use PCI on other SoCs, so:

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

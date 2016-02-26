From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 16:51:40 +0900
Subject: [RESPIN 0/6] Add support for Exynos SROM Controller driver.
In-Reply-To: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56D0040C.8020204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2016 17:33, Pankaj Dubey wrote:
> This series is collection of patches already reviewed and merged in
> maintainer's tree, but could not make it thorugh main linus tree, due
> to last moment suggestion of proper location of driver should be
> "drivers/memory" instead of "drivers/soc". I have rebased all the patches
> and moved into "drivers/memory/samsung".
> 
> As this is just a movement without changing actual driver code,
> I have not removed "Reviewed-By", "Tested-By" or "Acked-By".
> 
> To make sure everything is fine, I have again tested it on Exynos5880 based
> Chromebook for normal boot, S2R functionality and its working fine.
> 
> This series has been prepared on top of next-soc branch of Krzysztof's tree.
> 
> Changes w.r.t. original merged patches:
>  - Moved exynos-srom driver into "drivers/memory/samsung"
>  - Moved DT binding documentation into "bindings/memory-controller"
>  - Added new patch for entry of new directory in MAINTAINERS file.
>  - Added new CONFIG as SAMSUNG_MC for grouping Samsung's memory controller drivers.
>  - Added my Signed-off-by for patch 5/6 and 6/6 for touching it.
> 
> Pankaj Dubey (4):
>   dt-bindings: EXYNOS: Add exynos-srom device tree binding
>   drivers: memory: Add support for exynos SROM driver
>   MAINTAINERS: Add maintainers entry for drivers/memory/samsung
>   ARM: EXYNOS: Remove SROM related register settings from mach-exynos
> 
> Pavel Fedin (2):
>   dt-bindings: EXYNOS: Describe SROMc configuration
>   drivers: memory: exynos-srom: Add support for bank configuration

Thanks!

The driver was put under samsung subdirectory of drivers/memory because
Pankaj has a plan to add more stuff there. This way we can avoid
unnecessary movements of files (making history reading more difficult).


I applied (with fixes mentioned in my comments) everything and pushed
here so everyone could play with it:
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=for-v4.6/drivers-soc-exynos-srom-2


It is also included in for-next.

If there is no comments then I will send it in pull request for v4.6.

Best regards,
Krzysztof

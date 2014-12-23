From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 23 Dec 2014 10:29:22 +0530
Subject: clk: samsung: exynos7: Add clocks for MSCL block
In-Reply-To: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
References: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
Message-ID: <5498F6AA.8010405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 17 December 2014 01:03 PM, tony nadackal wrote:
> Add clock support for the MSCL block for Exynos7.
>
> Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
>
> ---
> .../devicetree/bindings/clock/exynos7-clock.txt    |   1 +
>   drivers/clk/samsung/clk-exynos7.c                  | 124 +++++++++++++++++++++
>   include/dt-bindings/clock/exynos7-clk.h            |  40 ++++++-
>   3 files changed, 164 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> index 6d3d5f8..d0e048c 100644
> --- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> @@ -34,6 +34,7 @@ Required Properties for Clock Controller:
>   	- "samsung,exynos7-clock-peris"
>   	- "samsung,exynos7-clock-fsys0"
>   	- "samsung,exynos7-clock-fsys1"
> +	- "samsung,exynos7-clock-mscl"
>
>    - reg: physical base address of the controller and the length of
>   	memory mapped region.
> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
> index a79bf23..95c1160 100644
> --- a/drivers/clk/samsung/clk-exynos7.c
> +++ b/drivers/clk/samsung/clk-exynos7.c
> @@ -34,6 +34,7 @@
>   #define DIV_TOPC0		0x0600
>   #define DIV_TOPC1		0x0604
>   #define DIV_TOPC3		0x060C
> +#define	ENABLE_ACLK_TOPC1	0x0804

nit: Tab space between #define and ENABLE_ACLK_TOPC1, should be removed.


I verified register settings and clock relationships are as per UM I 
have with me. So other than above nit, everything looks fine.

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>


Thanks,
Pankaj Dubey

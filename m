From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 05 Jan 2010 01:42:53 +0900
Subject: [PATCH] NUC900: Add extern header file support for some driver
In-Reply-To: <4B3F69ED.2030404@gmail.com>
References: <4B3F69ED.2030404@gmail.com>
Message-ID: <4B421A8D.2020504@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:
> Dear Wang Qiang,
> 
> This patch provides a API for your LCD driver or other drivers, if you
> want to use those APIs, please include corresponding header file.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> ---
>  arch/arm/mach-w90x900/include/mach/clkdev.h |    3 +++
>  arch/arm/mach-w90x900/include/mach/mfp.h    |   23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-w90x900/include/mach/mfp.h
> 
> diff --git a/arch/arm/mach-w90x900/include/mach/clkdev.h
> b/arch/arm/mach-w90x900/include/mach/clkdev.h
> index 04b37a8..b35f4bc 100644
> --- a/arch/arm/mach-w90x900/include/mach/clkdev.h
> +++ b/arch/arm/mach-w90x900/include/mach/clkdev.h
> @@ -4,4 +4,7 @@
>  #define __clk_get(clk) ({ 1; })
>  #define __clk_put(clk) do { } while (0)
> 
> +extern void nuc900_driver_clksrc_div(struct device *dev, unsigned char
> *src,
> +							unsigned char divider);
> +

hmm, why not have a 'struct clk' with a .set_rate method?

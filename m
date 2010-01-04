From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2010 16:58:27 +0000
Subject: [PATCH] NUC900: Add extern header file support for some driver
In-Reply-To: <4B3F69ED.2030404@gmail.com>
References: <4B3F69ED.2030404@gmail.com>
Message-ID: <20100104165827.GB14533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 02, 2010 at 11:44:45PM +0800, Wan ZongShun wrote:
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

I'd prefer it if this header didn't get used for non-clkdev<->plat code
stuff.

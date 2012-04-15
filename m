From: robherring2@gmail.com (Rob Herring)
Date: Sat, 14 Apr 2012 22:18:01 -0500
Subject: [PATCH 1/4] clk: select CLKDEV_LOOKUP for COMMON_CLK
In-Reply-To: <1334003101-17274-2-git-send-email-robherring2@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-2-git-send-email-robherring2@gmail.com>
Message-ID: <4F8A3DE9.8030008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On 04/09/2012 03:24 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Using the common clock infrastructure without the common clkdev code makes
> little sense, so select CLKDEV_LOOKUP for COMMON_CLK.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---

Can you apply the 1st 2 patches in this series to your clock fixes tree
for 3.4?

Rob

>  drivers/clk/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 165e1fe..f05a60d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -12,6 +12,7 @@ config HAVE_MACH_CLKDEV
>  config COMMON_CLK
>  	bool
>  	select HAVE_CLK_PREPARE
> +	select CLKDEV_LOOKUP
>  	---help---
>  	  The common clock framework is a single definition of struct
>  	  clk, useful across many platforms, as well as an

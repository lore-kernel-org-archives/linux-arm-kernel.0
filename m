From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 27 Oct 2011 13:54:11 +0200
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E89C3FA.9020206@gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
Message-ID: <20111027115411.GA4713@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/22/2011 05:26 PM, Mike Turquette wrote:
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3530927..c53ed59 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
>  
>  config HAVE_MACH_CLKDEV
>  	bool
> +
> +config GENERIC_CLK
> +	bool

Now that Russel's prepare/unprepare patch is mainlined, I think you
want to select HAVE_CLK_PREPARE here (and remove your prepare/unprepare
function declarations in clk.h).

Regards,
Domenico

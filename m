From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jan 2010 10:35:46 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100111103545.GB3440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 06:44:32PM +0900, Kukjin Kim wrote:

> diff --git a/arch/arm/plat-samsung/include/mach/system.h b/arch/arm/plat-samsung/include/mach/system.h
> new file mode 100644
> index 0000000..5377792
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/mach/system.h
> @@ -0,0 +1,36 @@

...

> +void (*s3c_idle_fn)(void);

This should include idle.h to ensure consistency and the entire file
looks like it ought to be a .c file rather than a .h since it includes
function and variable definitions.

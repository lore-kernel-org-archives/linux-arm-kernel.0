From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Nov 2016 10:38:27 +0000
Subject: [PATCH 0/6] mfd: audit and demodule drivers/mfd/ab* drivers
In-Reply-To: <20161030012440.10495-1-paul.gortmaker@windriver.com>
References: <20161030012440.10495-1-paul.gortmaker@windriver.com>
Message-ID: <20161111103827.GE13638@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Oct 2016, Paul Gortmaker wrote:

> Nothing new here ; just another instance where we had modular remove
> and exit functions -- but the Makefile/Kconfig limited the use case to
> being always built-in; hence the code is useless and needs removing.
> 
> So we remove the dead code and the misleading hints of modularity from
> these drivers, hoping that we manage to prevent some new drivers from
> copying these same old mistakes into pending new drivers.
> 
> Paul.
> ---
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mattias Wallin <mattias.wallin@stericsson.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> 
> Paul Gortmaker (6):
>   mfd: ab3100-core: Make it explicitly non-modular
>   mfd: ab8500-core: Make it explicitly non-modular
>   mfd: ab8500-debugfs: Make it explicitly non-modular
>   mfd: ab8500-gpadc: Make it explicitly non-modular
>   mfd: ab8500: make sysctrl explicitly non-modular
>   mfd: abx500-core: drop unused MODULE_ tags from non-modular code

Applied the series with Linus' Ack.

>  drivers/mfd/ab3100-core.c    | 39 +++------------------------------------
>  drivers/mfd/ab8500-core.c    | 37 ++++++-------------------------------
>  drivers/mfd/ab8500-debugfs.c | 21 ++-------------------
>  drivers/mfd/ab8500-gpadc.c   | 19 ++-----------------
>  drivers/mfd/ab8500-sysctrl.c |  9 ++++-----
>  drivers/mfd/abx500-core.c    |  7 ++-----
>  6 files changed, 19 insertions(+), 113 deletions(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

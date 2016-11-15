From: oss@buserror.net (Scott Wood)
Date: Mon, 14 Nov 2016 23:10:24 -0600
Subject: [PATCH 3/3] soc: fsl: make guts driver explicitly non-modular
In-Reply-To: <20161113190302.18099-4-paul.gortmaker@windriver.com>
References: <20161113190302.18099-1-paul.gortmaker@windriver.com>
 <20161113190302.18099-4-paul.gortmaker@windriver.com>
Message-ID: <1479186624.21746.15.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-11-13 at 14:03 -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/soc/fsl/Kconfig:config FSL_GUTS
> drivers/soc/fsl/Kconfig:????????bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since the code was already not using module_init, the init ordering
> remains unchanged with this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Cc: Scott Wood <oss@buserror.net>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Scott Wood <oss@buserror.net>

-Scott

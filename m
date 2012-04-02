From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 22:53:41 +0100
Subject: [PATCH] clkdev: Implement managed clk_get()
In-Reply-To: <1333403385-24133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333403385-24133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120402215341.GL24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 10:49:45PM +0100, Mark Brown wrote:
> Allow clk API users to simplify their cleanup paths by providing a
> managed version of clk_get() and clk_put().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Much better, thanks.  One minor comment...

> ---
>  Documentation/driver-model/devres.txt |    3 ++
>  drivers/clk/clkdev.c                  |   45 +++++++++++++++++++++++++++++++++
>  include/linux/clk.h                   |   32 +++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 2a596a4..3a10848 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -276,3 +276,6 @@ REGULATOR
>    devm_regulator_get()
>    devm_regulator_put()
>    devm_regulator_bulk_get()
> +
> +CLOCK
> +  devm_clk_get()

devm_clk_put() ?

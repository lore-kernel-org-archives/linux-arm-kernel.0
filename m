From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 16 Mar 2012 15:33:04 -0700
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
 <201203162057.58706.arnd@arndb.de>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
Message-ID: <CAJOA=zPmy7Dwzw8EOCW_+cvy2Dv=w0TPUq7Zg_s=Y0rs+v+u2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 3:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 16 Mar 2012 16:06:30 -0600
> Subject: [PATCH] clk: mark the common clk code as EXPERIMENTAL for now
>
> Mark the common clk code as depending on CONFIG_EXPERIMENTAL. ?The API
> is not well-defined and both it and the underlying mechanics are likely
> to need significant changes to support non-trivial uses of the rate
> changing code, such as DVFS with external I/O devices. ?So any platforms
> that switch their implementation over to this may need to revise much
> of their driver code and revalidate their implementations until the
> behavior of the code is better-defined.
>
> A good time for removing this EXPERIMENTAL designation would be after at
> least two platforms that do DVFS on groups of external I/O devices have
> ported their clock implementations over to the common clk code.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@ti.com>

ACK.  This will set some reasonable expectations while things are in flux.

Arnd are you willing to take this in?

Thanks,
Mike

> ---
> ?drivers/clk/Kconfig | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 2eaf17e..a0a83de 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -12,6 +12,7 @@ config HAVE_MACH_CLKDEV
> ?menuconfig COMMON_CLK
> ? ? ? ?bool "Common Clock Framework"
> ? ? ? ?select HAVE_CLK_PREPARE
> + ? ? ? depends on EXPERIMENTAL
> ? ? ? ?---help---
> ? ? ? ? ?The common clock framework is a single definition of struct
> ? ? ? ? ?clk, useful across many platforms, as well as an
> --
> 1.7.9.1
>

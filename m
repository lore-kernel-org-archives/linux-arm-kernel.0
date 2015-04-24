From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 24 Apr 2015 08:40:17 -0700
Subject: [PATCH] gpio: omap: Allow building as a loadable module
In-Reply-To: <1429833382-28532-1-git-send-email-tony@atomide.com>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
Message-ID: <553A63E1.1060407@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2015 4:56 PM, Tony Lindgren wrote:
> We currently get all kinds of errors building the omap gpio driver
> as a module starting with:
>
> undefined reference to `omap2_gpio_resume_after_idle'
> undefined reference to `omap2_gpio_prepare_for_idle'
> ...
>
> Let's fix the issue by adding inline functions to the header.
> Note that we can now also remove the two unused functions for
> omap_set_gpio_debounce and omap_set_gpio_debounce_time.
>
> Then doing rmmod on the module produces further warnings
> because of missing exit related functions. Let's add those.
>
> And finally, we can make the Kconfig entry just a tristate
> option that's selected for omaps.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/Kconfig                    |  2 +-
>   drivers/gpio/gpio-omap.c                | 24 ++++++++++++++++++++++++
>   include/linux/platform_data/gpio-omap.h | 12 ++++++++++--
>   3 files changed, 35 insertions(+), 3 deletions(-)
>
That platform header needs serious clean-up and we now
add two more inlines there.

But, being able to use gpio as loadable module
might be good enough reason to take this one.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

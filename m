From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 16 Oct 2010 20:49:20 +0200
Subject: [PATCH 1/2] ARM: imx: Add wake functionality to GPIO
In-Reply-To: <1287173908-25758-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287173908-25758-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101016184919.GC6225@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Fri, Oct 15, 2010 at 03:18:27PM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Add function definition for irq_chip.set_wake to enable GPIO to
> wake-up the system.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/plat-mxc/gpio.c              |   35 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/gpio.h |    3 ++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 57ec4a8..7647ba3 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c

[snip]

> diff --git a/arch/arm/plat-mxc/include/mach/gpio.h 
> b/arch/arm/plat-mxc/include/mach/gpio.h
> index af33b74..dba3768 100644
> --- a/arch/arm/plat-mxc/include/mach/gpio.h
> +++ b/arch/arm/plat-mxc/include/mach/gpio.h
> @@ -39,6 +39,9 @@ struct mxc_gpio_port {
>  	struct gpio_chip chip;
>  	u32 both_edges;
>  	spinlock_t lock;
> +	u32 suspend_wakeup;
> +	u32 saved_wakeup;
> +

Unneeded blank line.

>  };
>  
>  int mxc_gpio_init(struct mxc_gpio_port*, int);

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

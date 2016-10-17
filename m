From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 17 Oct 2016 17:52:07 +0200
Subject: [PATCH] ARM/orion/gpio: Replace three seq_printf() calls by
 seq_puts() in orion_gpio_dbg_show()
In-Reply-To: <92ba3c30-386a-bb86-623d-0917cd9e61a2@users.sourceforge.net> (SF
 Markus Elfring's message of "Sun, 16 Oct 2016 12:38:26 +0200")
References: <92ba3c30-386a-bb86-623d-0917cd9e61a2@users.sourceforge.net>
Message-ID: <87a8e3ezx4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,
 
 On dim., oct. 16 2016, SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 16 Oct 2016 12:30:48 +0200
>
> Strings which did not contain data format specifications should be put
> into a sequence. Thus use the corresponding function "seq_puts".
>
> This issue was detected by using the Coccinelle software.
>
Applied on mvebu/drivers

Thanks,

Gregory

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/arm/plat-orion/gpio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index f740693..26a531e 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -478,13 +478,13 @@ static void orion_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  			   (data_in ^ in_pol) & msk  ? "hi" : "lo",
>  			   in_pol & msk ? "lo" : "hi");
>  		if (!((edg_msk | lvl_msk) & msk)) {
> -			seq_printf(s, " disabled\n");
> +			seq_puts(s, " disabled\n");
>  			continue;
>  		}
>  		if (edg_msk & msk)
> -			seq_printf(s, " edge ");
> +			seq_puts(s, " edge ");
>  		if (lvl_msk & msk)
> -			seq_printf(s, " level");
> +			seq_puts(s, " level");
>  		seq_printf(s, " (%s)\n", cause & msk ? "pending" : "clear  ");
>  	}
>  }
> -- 
> 2.10.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

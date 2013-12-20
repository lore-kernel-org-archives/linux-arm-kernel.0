From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Dec 2013 10:53:50 +0000 (UTC)
Subject: [PATCHv11 01/49] clk: add support for registering clocks from
 description
In-Reply-To: <1387452260-23276-2-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312201046510.20802@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Dec 2013, Tero Kristo wrote:

> From: Mike Turquette <mturquetter@linaro.org>

Is this E-mail address correct?  It's one byte off of the Signed-off-by: 
address.

> clk_register_desc is the primary interface for populating the clock tree
> with new clock nodes. In time, this will replace the various hardware-specific
> registration functions (e.g. clk_register_gate).
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

...

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2cf2ea6..29281f6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1905,6 +1905,77 @@ fail_out:
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7e59253..7fddcb3 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -161,6 +161,28 @@ struct clk_init_data {
>  };
>  
>  /**
> + * struct clk_desc - clock init descriptor for providing init time parameters
> + * for a clock.
> + *
> + * @name: clock name

As mentioned in 

http://patchwork.ozlabs.org/patch/294253/

please remove the blank line between the summary line and the arguments.  
Documentation/kernel-doc-nano.txt says:

"The @argument descriptions must begin on the very next line following
this opening short function description line, with no intervening
empty comment lines."


- Paul

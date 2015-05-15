From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 22:09:28 +0200
Subject: [PATCH 1/2] arm: devtree: Save atags if are in DT atags field
In-Reply-To: <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
Message-ID: <2802980.ITgIdpK9OB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 21:50:06 Pali Roh?r wrote:
> @@ -256,5 +257,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>                         system_rev = 0;
>         }
>  
> +       /* Save atags */
> +       prop = of_get_flat_dt_prop(dt_root, "atags", NULL);
> +       if (prop)
> +               save_atags((void *)prop);
> +
>         return mdesc;
> 

How about checking whether this is actually running on the one board
that needs it first?

I'd rather not introduce something that may end up being considered
an ABI on other machines.

	Arnd

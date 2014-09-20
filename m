From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 20 Sep 2014 15:19:50 +0200
Subject: [PATCH 1/2] bus: brcmstb_gisb: register the fault code hook
In-Reply-To: <1411155880-23447-2-git-send-email-f.fainelli@gmail.com>
References: <1411155880-23447-1-git-send-email-f.fainelli@gmail.com>
 <1411155880-23447-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140920151950.443b7ea9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Fri, 19 Sep 2014 12:44:39 -0700, Florian Fainelli wrote:

> -void __init brcmstb_hook_fault_code(void)
> +static int __init brcmstb_hook_fault_code(void)
>  {
>  	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
>  			"imprecise external abort");
> +	return 0;
>  }
> +arch_initcall(brcmstb_hook_fault_code)

I don't have the entire context, but if your platform is part of
multi-platform, it means that regardless of which platform is actually
booting your system, you will register your fault hook. Is this the
intended behavior?

Generally speaking, in a multiplatform context, many arch_initcall()
should have a conditional to check whether we're really on a platform
where the initcall is needed.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 17 Oct 2012 19:04:04 +0530
Subject: [PATCH] drivers: bus: omap_interconnect: Fix rand-config build
 warning
In-Reply-To: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
References: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <507EB3CC.6060005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Looping Arnd and Olof)

On Wednesday 17 October 2012 06:58 PM, Lokesh Vutla wrote:
> When building omap_l3_noc/smx drivers as modules, the following
> warning appears:
>
> CC [M]  drivers/bus/omap_l3_smx.o
> drivers/bus/omap_l3_smx.c:291: warning: data definition has no type or storage class
> drivers/bus/omap_l3_smx.c:291: warning: type defaults to 'int' in declaration of 'postcore_initcall_sync'
> drivers/bus/omap_l3_smx.c:291: warning: parameter names (without types) in function declaration
> drivers/bus/omap_l3_smx.c:287: warning: 'omap3_l3_init' defined but not used
> CC [M]  drivers/bus/omap_l3_noc.o
> drivers/bus/omap_l3_noc.c:260: warning: data definition has no type or storage class
> drivers/bus/omap_l3_noc.c:260: warning: type defaults to 'int' in declaration of 'arch_initcall_sync'
> drivers/bus/omap_l3_noc.c:260: warning: parameter names (without types) in function declaration
> drivers/bus/omap_l3_noc.c:256: warning: 'omap4_l3_init' defined but not used
>
> Adding module_init() and macros in omap_l3_noc/smx drivers when building
> as modules to remove the above warning.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
Thanks for the fix Lokesh. Looks fine to me.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

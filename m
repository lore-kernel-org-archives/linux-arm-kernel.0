From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 22 Jul 2013 15:09:10 +0100
Subject: [PATCH v3] xen/arm: enable PV control for ARM
In-Reply-To: <1374490654-13373-1-git-send-email-julien.grall@linaro.org>
References: <1374490654-13373-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307221508260.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Julien Grall wrote:
> Enable power management from the toolstack for ARM guest.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> 

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>     Changes in v3:
>         - Fix condition to compile cpu_hotplug.o
>     Changes in v2:
>         - Don't compile xen/cpu_hotplug.o with ARM64
> ---
>  drivers/xen/Makefile |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 2bf461a..f185e8d 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,9 +1,8 @@
> -ifneq ($(CONFIG_ARM),y)
> -obj-y	+= manage.o
> +ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
>  obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>  endif
>  obj-$(CONFIG_X86)			+= fallback.o
> -obj-y	+= grant-table.o features.o events.o balloon.o time.o
> +obj-y	+= grant-table.o features.o events.o balloon.o time.o manage.o
>  obj-y	+= xenbus/
>  
>  nostackp := $(call cc-option, -fno-stack-protector)
> -- 
> 1.7.10.4
> 

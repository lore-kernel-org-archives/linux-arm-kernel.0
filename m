From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jul 2013 16:28:53 +0100
Subject: [PATCH v5] xen/arm: enable PV control for ARM
In-Reply-To: <1374592888-5520-1-git-send-email-julien.grall@linaro.org>
References: <1374592888-5520-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307231628330.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Julien Grall wrote:
> Enable lifecyle management (reboot, shutdown...) from the toolstack
> for ARM guest.
              ^ guests

> Signed-off-by: Julien Grall <julien.grall@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


> ---
>     Changes in v5:
>         - Rework commit message
>     Changes in v4:
>         - Divide the patch in 2 distinct parts
>     Changes in v3:
>         - Fix condition to compile cpu_hotplug.o
>     Changes in v2:
>         - Don't compile xen/cpu_hotplug.o with ARM64
> ---
>  drivers/xen/Makefile |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index a609353..f185e8d 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,9 +1,8 @@
>  ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
> -obj-y	+= manage.o
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

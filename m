From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 17 Jul 2013 14:40:31 +0100
Subject: [PATCH] xen/arm: enable PV control for ARM
In-Reply-To: <1373898219-15713-1-git-send-email-julien.grall@linaro.org>
References: <1373898219-15713-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307171435000.8258@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jul 2013, Julien Grall wrote:
> Enable power management from the toolstack for ARM guest.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>

Considering that now we support both ARM and ARM64, could you please
add an ifneq ($(CONFIG_ARM64),y) too around cpu_hotplug.o, since you are
at it?


>  drivers/xen/Makefile |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 2bf461a..a5f12bd 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,9 +1,8 @@
>  ifneq ($(CONFIG_ARM),y)
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

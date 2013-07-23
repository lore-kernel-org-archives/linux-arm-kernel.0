From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jul 2013 12:35:40 +0100
Subject: [PATCH] xen/arm64: Don't compile cpu hotplug
In-Reply-To: <1374529258-12866-1-git-send-email-julien.grall@linaro.org>
References: <1374529258-12866-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307231235330.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Julien Grall wrote:
> On ARM64, when CONFIG_XEN=y, the compilation will fail because CPU hotplug is
> not yet supported with XEN. For now, disable it.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  drivers/xen/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 2bf461a..a609353 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,4 +1,4 @@
> -ifneq ($(CONFIG_ARM),y)
> +ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
>  obj-y	+= manage.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>  endif
> -- 
> 1.7.10.4
> 

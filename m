From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 7 Mar 2012 11:52:03 +1100
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAGRGNgWHXrQgVobz+54sFBzj=bTHCKwg+H4_CY5JoGtmETw2yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Mar 7, 2012 at 11:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> if their arch Kconfig allows it, and they desire.
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> diff --git a/init/Kconfig b/init/Kconfig
> index 6cfd71d..2035562 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -203,6 +203,21 @@ config KERNEL_LZO
>
> ?endchoice
>
> +config ALLOW_UIMAGE_KERNEL_NOLOAD
> + ? ? ? bool
> +
> +config UIMAGE_KERNEL_NOLOAD
> + ? ? ? bool "Use mkimage's -T kernel_noload instead of -T kernel"
> + ? ? ? depends on ALLOW_UIMAGE_KERNEL_NOLOAD
> + ? ? ? help
> + ? ? ? ? uImage files of type "kernel" embed an absolute load and entry point
> + ? ? ? ? address. If the uImage is loaded to a different address, then the
> + ? ? ? ? image must be copied the uImage file to the specified load address.

You seem to have an excess "the uImage file" in here.

> + ? ? ? ? This copy is a waste of time if the uImage is in fact completely
> + ? ? ? ? relocatable. If your kernel and bootloader support it, you can build
> + ? ? ? ? a "kernel_noload" uImage rather than a "kernel" uImage, which
> + ? ? ? ? prevents any such copying. If unsure say N.
> +
> ?config DEFAULT_HOSTNAME
> ? ? ? ?string "Default hostname"
> ? ? ? ?default "(none)"

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

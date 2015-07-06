From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 6 Jul 2015 21:19:55 +0300
Subject: VDSO build failure: collect2: fatal error: cannot find 'ld'
In-Reply-To: <559A8570.6080602@mentor.com>
References: <20150706065408.GI3139@tarshish>
 <559A8570.6080602@mentor.com>
Message-ID: <20150706181955.GJ3139@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Mon, Jul 06, 2015 at 08:41:04AM -0500, Nathan Lynch wrote:
> On 07/06/2015 01:54 AM, Baruch Siach wrote:
> > Reverting d2b30cd4b722 on v4.2-rc1 fixes the build failure.
> 
> Baruch, can you confirm the patch below fixes it for you?
> 
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 9d259d94e429..1160434eece0 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -14,7 +14,7 @@ VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
> -Wl,-z,common-page-size=4096
>  VDSO_LDFLAGS += -nostdlib -shared
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> -VDSO_LDFLAGS += $(call cc-option, -fuse-ld=bfd)
> +VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
> 
>  obj-$(CONFIG_VDSO) += vdso.o
>  extra-$(CONFIG_VDSO) += vdso.lds

With this patch applied kernel build using the Sourcery CodeBench Lite 2014.05 
toolchain succeeds.

Tested-by: Baruch Siach <baruch@tkos.co.il>

Thanks for your prompt response.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

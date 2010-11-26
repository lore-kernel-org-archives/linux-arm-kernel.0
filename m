From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Fri, 26 Nov 2010 16:39:43 +0900
Subject: [RFC][PATCH 1/1] ARM: Add initial hibernation support
In-Reply-To: <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTin-ZCb7bdYhtUe00cPMs7m+Kjp0=4EEQ38i0q5Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 11:28 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>
> Based on the original work from Romit and Raghu at TI. The original
> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>
> *1: https://patchwork.kernel.org/patch/96442/
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

(snip)

> +config ARCH_HIBERNATION_POSSIBLE
> + ? ? ? def_bool y
> + ? ? ? depends on CPU_V7 && !SMP
> +

(snip)

> +/*
> + * FIXME: Only support for Cortex A8 now
> + */

(snip)

> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,7 +149,6 @@ SECTIONS
> ? ? ? ? ? ? ? ?__init_end = .;
> ?#endif
>
> - ? ? ? ? ? ? ? NOSAVE_DATA
> ? ? ? ? ? ? ? ?CACHELINE_ALIGNED_DATA(32)
>
> ? ? ? ? ? ? ? ?/*
> @@ -172,6 +171,8 @@ SECTIONS
> ? ? ? ?}
> ? ? ? ?_edata_loc = __data_loc + SIZEOF(.data);
>
> + ? ? ? NOSAVE_DATA
> +
> ?#ifdef CONFIG_HAVE_TCM
> ? ? ? ? /*
> ? ? ? ? * We align everything to a page boundary so we can
> --

I have been working on the hibernation feature on S5PC210 (ARM Cortex
A9 MP-Core) based on this patch and it's working find with minor
modifications. (and will send as soon as clutters are removed and
tested further)

However, I've got a question on your patch: is it really necessary to
patch [arch/arm/kernel/vmlinux.lds.S] file? Without patching that
file, it works fine at my system (although it's based on 2.6.36, not
37 rc #) and with that patch, the linker spits an error. If it's
necessary to patch [arch/arm/kernel/vmlinux.lds.S], could you please
explain a bit about it?

Thank you.


- MyungJoo

> 1.7.1.rc2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858

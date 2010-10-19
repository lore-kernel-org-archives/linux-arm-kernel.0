From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 19 Oct 2010 15:39:46 +0800
Subject: [PATCHv3] cpufreq for freescale mx51
In-Reply-To: <20101018100250.GB2562@matterhorn.lan>
References: <1287390105-3706-1-git-send-email-yong.shen@linaro.org>
	<20101018100250.GB2562@matterhorn.lan>
Message-ID: <AANLkTikqQtmSxMqPAcv0prhuG=DK3tpR8Uf4V+sJpXWk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi amit,

On Mon, Oct 18, 2010 at 6:02 PM, Amit Kucheria <amit.kucheria@linaro.org>wrote:

> Yong,
>
> I get the following errors if I try to compile this with the Linaro
> toolchain.
>
> In file included from
>
> /home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/include/mach/hardware.h:63:0,
>                 from
>
> /home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/devices/platform-fec.c:10:
>
> /home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/include/mach/mxc.h:139:2:
>                 error: expected specifier-qualifier-list before ?u32?
>
> Perhap following patch is required?
>
> diff --git a/arch/arm/plat-mxc/include/mach/hardware.h
> b/arch/arm/plat-mxc/include/mach/hardware.h
> index ebadf4a..c9587fd 100644
> --- a/arch/arm/plat-mxc/include/mach/hardware.h
> +++ b/arch/arm/plat-mxc/include/mach/hardware.h
> @@ -21,6 +21,7 @@
>  #define __ASM_ARCH_MXC_HARDWARE_H__
>
>   #include <asm/sizes.h>
>   +#include <asm/types.h>
>
Although I did not meet this problem, I also think it is an issue.

>
> > +     u32 pll_reg;
> > +     u32 pll_rate;
> > +     u32 cpu_rate;
> > +     u32 pdr0_reg;
> > +     u32 pdf;
> > +     u32 mfi;
> > +     u32 mfd;
> > +     u32 mfn;
> > +     u32 cpu_voltage;
> > +     u32 cpu_podf;
> > +};
> > +
>
> Get rid of all members of struct cpu_op except cpu_rate for now. We can
> re-add it later.
>
> Also, I wonder if this struct and the external declaration should be moved
> out to plat/mxc_cpufreq.h
>
Maybe to mach/mxc.h which is the place for keeping platform related
definitions.


>
> > +extern struct cpu_op *(*get_cpu_op)(int *op);
> > +#endif
> > +
> >  #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
> >  /* These are deprecated, use mx[23][157]_setup_weimcs instead. */
> >  #define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
> > --
> > 1.6.3.3
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/e46aab58/attachment-0001.html>

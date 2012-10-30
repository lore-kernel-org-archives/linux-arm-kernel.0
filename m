From: mturquette@ti.com (Mike Turquette)
Date: Tue, 30 Oct 2012 03:11:40 -0700
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20121030150627.ac1f6a3f75231ea49edf7b98@canb.auug.org.au>
References: <20121030150627.ac1f6a3f75231ea49edf7b98@canb.auug.org.au>
Message-ID: <20121030101140.18780.69840@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Rothwell (2012-10-29 21:06:27)
> Hi Mike,
> 
> Today's linux-next merge of the clk tree got a conflict in
> arch/arm/include/asm/hardware/sp810.h between commit 0891642cf117 ("ARM:
> vexpress: Start using new Versatile Express infrastructure") from the
> arm-soc tree and commit 05e3659135a4 ("clk: Common clocks implementation
> for Versatile Express") from the clk tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/include/asm/hardware/sp810.h
> index 2cdcf44,afd7e91..0000000
> --- a/arch/arm/include/asm/hardware/sp810.h
> +++ b/arch/arm/include/asm/hardware/sp810.h
> @@@ -50,6 -50,14 +50,8 @@@
>   #define SCPCELLID2            0xFF8
>   #define SCPCELLID3            0xFFC
>   
>  -#define SCCTRL_TIMEREN0SEL_REFCLK     (0 << 15)
>  -#define SCCTRL_TIMEREN0SEL_TIMCLK     (1 << 15)
>  -
>  -#define SCCTRL_TIMEREN1SEL_REFCLK     (0 << 17)
>  -#define SCCTRL_TIMEREN1SEL_TIMCLK     (1 << 17)
>  -
> + #define SCCTRL_TIMERENnSEL_SHIFT(n)   (15 + ((n) * 2))
> + 
>   static inline void sysctl_soft_reset(void __iomem *base)
>   {
>         /* switch to slow mode */

Pawel,

Does this look OK for you?

Thanks,
Mike

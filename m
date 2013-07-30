From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Jul 2013 14:42:33 -0500
Subject: [PATCHv4 10/33] ARM: OMAP4: remove old clock data and link in
 new clock init code
In-Reply-To: <1374564028-11352-11-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-11-git-send-email-t-kristo@ti.com>
Message-ID: <51F81729.5010406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:

> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> deleted file mode 100644
> index 88e37a4..0000000
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ /dev/null
[...]
> -
> -int __init omap4xxx_clk_init(void)
> -{
arch/arm/mach-omap2/clock44xx.h:int omap4xxx_clk_init(void);
arch/arm/mach-omap2/io.c:       omap_clk_init = omap4xxx_clk_init;
code in drivers/clk/omap/clk-44xx.c

Seems goofy to me a little.
entire purpose of having a clk-44xx.c is:
a) doing a clk alias for device nodes
b) set_parent, rate
both of these seem to be an old style carry forward and should instead 
be fixes with generic properties IMHO voiding the need for SoC specific 
inits.

instead all we should be doing is call of_clk_init(NULL); at appropriate 
init sequence.

-- 
Regards,
Nishanth Menon

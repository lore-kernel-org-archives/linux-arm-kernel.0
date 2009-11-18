From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 18 Nov 2009 22:32:41 +0000
Subject: [PATCH] Add Samsung S5PC110 SoC support
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091118223241.GD4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 02:32:55PM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This preliminary patch series adds support for Samsung S5PC110 SoC.
> S5PC110 belongs to S5PC1XX family (CortexA8 ARM core), but differs in
> many places from the S5PC100 SoC: new memory map, different clock
> hierarchy, new gpio banks and much more powerful integrated peripherals.
> Such differences cannot be easily handled in the current Samsung
> machine&platform framework. To avoid duplication of code and adding yet
> another plat-* directory, we decided to introduce sub-platforms in
> the current s5pc1xx platform.
> 
> First 8 patches prepare s5pc1xx platform code for introduction of the
> new sub-platform approach. Then in the next 11 patches all core
> functions and drivers are subsequently added, so S5PC110 sub-platform
> gets similar level of support as S5PC100.
> 
> This patch series has been prepared against latest ARM Kernel tree from
> http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/
> 
> I know that Ben is working hard on new Samsung SoC platform framework,
> but stabilizing it and porting all the existing Samsung platforms would
> take time. This sub-platform solution is already prepared and until the
> new framework will be available and merged, we would like to use our
> approach.

running these through checkpatch first would have been a good idea:

fyi, these need fixing:

WARNING: externs should be avoided in .c files
#666: FILE: arch/arm/plat-s5pc1xx/s5pc110-clocks.c:92:
+extern struct clk clk_dout_hclkm;

WARNING: externs should be avoided in .c files
#667: FILE: arch/arm/plat-s5pc1xx/s5pc110-clocks.c:93:
+extern struct clk clk_dout_hclkd;

WARNING: externs should be avoided in .c files
#668: FILE: arch/arm/plat-s5pc1xx/s5pc110-clocks.c:94:
+extern struct clk clk_dout_hclkp;

WARNING: externs should be avoided in .c files
#669: FILE: arch/arm/plat-s5pc1xx/s5pc110-clocks.c:95:
+extern struct clk clk_dout_pclkd;

WARNING: externs should be avoided in .c files
#670: FILE: arch/arm/plat-s5pc1xx/s5pc110-clocks.c:96:
+extern struct clk clk_dout_pclkp;

#348: FILE: arch/arm/mach-s5pc110/include/plat/irqs.h:197:
+#define IRQ_EINT_BIT(x)		(x < IRQ_EINT16_31 ? x - IRQ_EINT0 : x - S3C_EINT(0))

could this be made an inline, or@least have x encased in brackets to
avoid any problems with macro expansion?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

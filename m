From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 23 Jun 2010 08:27:40 +0900
Subject: Samsung SoCs: preparation for single kernel
Message-ID: <AANLkTinGwWzIAOe2tj6V2kCrMiPT7PHlYs1kFS-IsiN4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To Ben,

I really need single kernel for s5pc110 (cortex A8) and s5pc210
(cortex A9) at least.
Fortunately arm move to these approaches recently. but current Samsung
SoCs not prepare these one.

So I wonder do you have a plan or how to address these issues?
How to assign the address at resources and use it at runtime?

Personally I want to use cpu_is_*. but you reject it to use.
Other way is that we can create the base address variables and assign
it at init time.

Please give your opinions.

Thank you,
Kyungmin Park

e.g., cpu_is_* usage at OMAP tree

static void omap_init_mcspi(void)
{
        if (cpu_is_omap44xx())
                omap4_mcspi_fixup();

        platform_device_register(&omap2_mcspi1);
        platform_device_register(&omap2_mcspi2);

        if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
                omap2_mcspi3_init();

        if (cpu_is_omap343x() || cpu_is_omap44xx())
                omap2_mcspi4_init();
}

From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 16:22:01 -0700
Subject: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
In-Reply-To: <20150225155627.GP11056@atomide.com>
References: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
 <20150225154445.GO11056@atomide.com> <54EDEFC9.606@ti.com>
 <20150225155627.GP11056@atomide.com>
Message-ID: <20150316232200.GX12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150225 08:10]:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150225 07:56]:
> > On 02/25/2015 05:44 PM, Tony Lindgren wrote:
> > >* grygorii.strashko at linaro.org <grygorii.strashko@linaro.org> [150225 06:17]:
> > >>From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> > >>
> > >>Add missed callback needed for supporting suspend-to-disk (hibernation) mode.
> > >
> > >Is this needed as a fix for the -rc series or are there still
> > >other missing dependencies?
> > >
> > 
> > This one is not critical fix.
> 
> OK thanks for confirming that.

Applying into omap-for-v4.1/soc thanks.
 
> Tony
> 
> > >>Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> > >>---
> > >>  arch/arm/mach-omap2/omap_device.c | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >>diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> > >>index fcd2c9e..345e18e 100644
> > >>--- a/arch/arm/mach-omap2/omap_device.c
> > >>+++ b/arch/arm/mach-omap2/omap_device.c
> > >>@@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
> > >>  		USE_PLATFORM_PM_SLEEP_OPS
> > >>  		.suspend_noirq = _od_suspend_noirq,
> > >>  		.resume_noirq = _od_resume_noirq,
> > >>+		.freeze_noirq = _od_suspend_noirq,
> > >>+		.thaw_noirq = _od_resume_noirq,
> > >>+		.restore_noirq = _od_resume_noirq,
> > >>  	}
> > >>  };
> > >>
> > >>--
> > >>1.9.1
> > >>
> > 
> > regards,
> > -grygorii
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

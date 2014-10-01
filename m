From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 01 Oct 2014 17:12:35 +0530
Subject: [PATCH 2/2] ARM: EXYNOS: PMU: move restart code into pmu driver
In-Reply-To: <542BD948.8040600@gmail.com>
References: <1412142540-3667-1-git-send-email-pankaj.dubey@samsung.com>
 <1412142540-3667-3-git-send-email-pankaj.dubey@samsung.com>
 <542BD948.8040600@gmail.com>
Message-ID: <002b01cfdd6c$e57b6730$b0723590$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wednesday, October 01, 2014 4:07 PM, Tomasz Figa wrote,
> To: Pankaj Dubey; linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org
> Cc: kgene.kim at samsung.com; linux at arm.linux.org.uk; thomas.ab at samsung.com;
> vikas.sajjan at samsung.com; linux at roeck-us.net; naushad at samsung.com
> Subject: Re: [PATCH 2/2] ARM: EXYNOS: PMU: move restart code into pmu
> driver
> 
> Hi Pankaj,
> 
> Please see my comments inline.
> 
> On 01.10.2014 07:49, Pankaj Dubey wrote:
> > Let's register reboot_notifier from PMU driver for reboot
> > functionality. So that we can remove restart hooks from machine
> > specific file, and thus moving ahead when PMU moved to driver folder,
> > this functionality can be reused for ARM64 based Exynos SoC's.
> 
> [snip]
> 
> > +static int pmu_reboot_notify_handler(struct notifier_block *this,
> > +		unsigned long code, void *unused)
> > +{
> > +	if (code == SYS_RESTART) {
> > +		u32 val = 0x1;
> > +
> > +		pmu_raw_writel(val, EXYNOS_SWRESET);
> 
> As already mentioned for patch 1, no need for the variable, because this
is just a
> constant 1.
> 

Thanks for review.
Addressed all your review comments for this patch series in v2.

Thanks,
Pankaj Dubey

> Best regards,
> Tomasz

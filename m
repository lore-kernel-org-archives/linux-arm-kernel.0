From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 17 Oct 2013 17:31:52 +0900
Subject: [PATCH] cpufreq: exynos: Convert exynos-cpufreq to platform driver
In-Reply-To: <CAK9yfHwW+ofX5f8hHF=MYQn=CUMyiHvg4iAH-cHFW7JQ5Qnscw@mail.gmail.com>
References: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
 <CAK9yfHwW+ofX5f8hHF=MYQn=CUMyiHvg4iAH-cHFW7JQ5Qnscw@mail.gmail.com>
Message-ID: <001d01cecb13$54ccd410$fe667c30$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 17, 2013 2:00 PM, Sachin Kamat wrote:
> On 16 October 2013 21:30, Tomasz Figa <t.figa@samsung.com> wrote:
> > From: Lukasz Majewski <l.majewski@samsung.com>
> >
> > +static struct platform_driver exynos_cpufreq_platdrv = {
> > +       .driver = {
> > +               .name   = "exynos-cpufreq",
> > +               .owner  = THIS_MODULE,
> > +       },
> > +       .probe = exynos_cpufreq_init,
> 
> I think the prototype of this function should be changed to:
> static int __init exynos_cpufreq_init(struct platform_device *pdev)
> 
> to avoid compilation warnings.

Hi Tomasz Figa,

One more thing. :-)

It makes section mismatch warning. Also, module_platform_driver()
is used. Then, '__init' annotation can be removed in order to fix
the section mismatch warning.

static int exynos_cpufreq_init(struct platform_device *pdev)

Thank you.

Best regards,
Jingoo Han

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Feb 2012 20:12:02 +0900
Subject: [PATCH V6 1/5] ARM: exynos: Add support AFTR mode on EXYNOS4210
In-Reply-To: <4F433E79.2090309@linaro.org>
References: <1329805190-8874-1-git-send-email-amit.kachhap@linaro.org>
 <1329805190-8874-2-git-send-email-amit.kachhap@linaro.org>
 <4F433E79.2090309@linaro.org>
Message-ID: <00b201ccf089$a2f039e0$e8d0ada0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> 
> Hi Amit,
> 
> On 02/21/2012 11:49 AM, Amit Daniel Kachhap wrote:
> > This patch adds support AFTR(ARM OFF TOP RUNNING) mode in
> > cpuidle driver. L2 cache keeps their data in this mode.
> > This patch ports the code to the latest interfaces to
> > save/restore CPU state inclusive of CPU PM notifiers, l2
> > resume and cpu_suspend/resume.
> >
> > Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > ---
> >  arch/arm/mach-exynos/cpuidle.c          |  147
> ++++++++++++++++++++++++++++++-
> >  arch/arm/mach-exynos/include/mach/pmu.h |    2 +
> >  2 files changed, 146 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> exynos/cpuidle.c
> 
> [ snip ]
> 
> > +static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv,
> > +				int index)
> > +{
> 
> [ snip ]
> 
> > +	scu_enable(S5P_VA_SCU);
> 
> #ifdef CONFIG_SMP
> 	scu_enable(S5P_VA_SCU);
> #endif
> 
> Without this, if SMP is not enabled, I am getting following build error.
> 
> arch/arm/mach-exynos/built-in.o: In function `exynos4_enter_core0_aftr':
> arch/arm/mach-exynos/cpuidle.c:131: undefined reference to `scu_enable'
> 
Thanks for your pointing out.

Let me fix it as per your comment when I apply this patch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

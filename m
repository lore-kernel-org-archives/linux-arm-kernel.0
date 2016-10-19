From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Oct 2016 19:22:08 +0530
Subject: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
In-Reply-To: <87r37d4qlw.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
 <20161018113835.GB11471@vireshk-i7> <87r37d4qlw.fsf@belgarion.home>
Message-ID: <20161019135208.GG11471@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-10-16, 17:35, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 15-10-16, 21:57, Robert Jarzmik wrote:
> >> For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
> >> doing the job as well as pxa2xx-cpufreq, so add these platforms to the
> >> compatibility list.
> >> 
> >> This won't work for legacy non device-tree platforms where
> >> pxa2xx-cpufreq is still required.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> index 0bb44d5b5df4..356825b5c9b8 100644
> >> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> >> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> @@ -32,6 +32,8 @@ static const struct of_device_id machines[] __initconst = {
> >>  	{ .compatible = "fsl,imx7d", },
> >>  
> >>  	{ .compatible = "marvell,berlin", },
> >> +	{ .compatible = "marvell,pxa250", },
> >> +	{ .compatible = "marvell,pxa270", },
> >>  
> >>  	{ .compatible = "samsung,exynos3250", },
> >>  	{ .compatible = "samsung,exynos4210", },
> >
> > Isn't there a race between cpufreq-dt and the platform driver to
> > register first ?
> Ah, could you be more specific about the race you're talking of ?
> 
> My understanding was that cpufreq-dt-platdev does create the device, and
> cpufreq-dt is a driver for it, so there is no race but a direct relationship
> AFAIU.

I mean that both the driver may try to register to the cpufreq core if
they are both compiled in a single image.

-- 
viresh

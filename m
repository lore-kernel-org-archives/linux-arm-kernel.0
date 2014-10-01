From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 01 Oct 2014 21:50:08 +0200
Subject: [PATCH v2 2/4] ARM: exynos: Ensure PM domains are powered at
 initialization
In-Reply-To: <542C2972.9070002@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-3-git-send-email-ulf.hansson@linaro.org>
 <542C2972.9070002@samsung.com>
Message-ID: <6158232.Yd6ncToJoF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 01, 2014 06:18:58 PM Sylwester Nawrocki wrote:
> On 01/10/14 16:41, Ulf Hansson wrote:
> > At ->probe() it's common practice for drivers/subsystems to bring their
> > devices to full power and without depending on CONFIG_PM_RUNTIME.
> > 
> > We could also expect that drivers/subsystems requires their device's
> > corresponding PM domains to be powered, to successfully complete a
> > ->probe() sequence.
> > 
> > Align to the behavior above, by ensuring all PM domains are powered
> > prior initialization of a generic PM domain.
> > 
> > Do note, since the generic PM domain will try to power off unused PM
> > domains at late_init, there should be no increased power consumption
> > over time, but potentially during boot.
> 
> Wouldn't it be a better idea to power on the power domains which are
> turned off only when CONFIG_PM_RUNTIME is not enabled ? I had a plan
> to submit a patch doing that but unfortunately this has fallen through
> the cracks. At the moment mach-exynos/pm_domains.c is not even built in
> when CONFIG_PM_RUNTIME is disabled.
> 
> I don't like the behaviour introduced in this patch to be the default,
> i.e. turning all possible power domains during boot sequence, even if
> some are not used and not needed. While we're trying to decrease the
> power consumption in any possible way this doesn't help at all.

Agreed (as stated before).

And I'm wondering why that comment of mine was ignored?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

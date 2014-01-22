From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jan 2014 17:10:07 +0100
Subject: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of
 module_init
In-Reply-To: <52DFE7D9.5050001@windriver.com>
References: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
 <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
 <1390402760.18340.6.camel@AMDC1943> <1390405030.18340.11.camel@AMDC1943>
 <52DFE7D9.5050001@windriver.com>
Message-ID: <1390407007.18340.13.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-22 at 10:46 -0500, Paul Gortmaker wrote:
> On 14-01-22 10:37 AM, Krzysztof Kozlowski wrote:
> > 
> >>
> >> Hi,
> >>
> >> A little more explanation from my side: the build error actually happens
> >> only on next/master, not Linus' tree.
> >>
> >> Mentioned commit which changes the driver to platform driver is in
> >> mainline since 3.12-rc2 so it seems this is not the cause of the build
> >> error. I think I need to find first the real cause of this build error.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > After bisecting, the real commit for build error is:
> > caa7dcde7c424cdc81698a6e4e48072eb67ec67e
> >     module: relocate module_init from init.h to module.h
> 
> Yep, even though I fixed a crap-tonne of implicit includes, and
> built all the arm configs, some were bound to sneak through.
> 
> I'll push a fix shortly to the init cleanup queue:
> 
>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/
> 
> so it will be fine for the next linux-next tree.

Thanks, the same issue applies to drivers/cpufreq/exynos-cpufreq.c.

Best regards,
Krzysztof

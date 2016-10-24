From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Oct 2016 09:03:41 +0530
Subject: [PATCH v2 4/4] cpufreq: pxa: convert to clock API
In-Reply-To: <877f902hh6.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
 <20161018114025.GD11471@vireshk-i7> <877f902hh6.fsf@belgarion.home>
Message-ID: <20161024033341.GA24749@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-10-16, 23:37, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 15-10-16, 21:57, Robert Jarzmik wrote:
> >> As the clock settings have been introduced into the clock pxa drivers,
> >> which are now available to change the CPU clock by themselves, remove
> >> the clock handling from this driver, and rely on pxa clock drivers.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >> Since v1: added !OF Kconfig dependency
> >> ---
> >>  drivers/cpufreq/Kconfig.arm      |   2 +-
> >>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
> >>  2 files changed, 40 insertions(+), 153 deletions(-)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Okay, after some more testing, I'd like to remove the !OF for next iteration.
> The reason is that I have a usecase where I have a single kernel image with
> devictree support (ie CONFIG_OF=y), but with support for both devicetree and
> legacy platforms. In this case, a platform such as lubbock can boot :
>  - with devicetree
>  - with legacy arch/arm/mach-pxa/lubbock.c
> 
> In this kernel, the !OF Kconfig prevents the legacy version from working, as
> pxa2xx-cpufreq is descarded even if it is needed in the legacy version.
> 
> Therefore, I'd like to respin without this !OF.

I imagined this case last week as well :)

No issues.

-- 
viresh

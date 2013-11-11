From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 11 Nov 2013 15:14:31 +0100
Subject: [PATCH 1/1] ARM: EXYNOS: Add default latency values for Device
 and Power Domain
In-Reply-To: <CAPmaG0t++EtdGmVg_JOZt-MU1Su=BDAe7L-tv-un3qkQRkebfg@mail.gmail.com>
References: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHz-iUfOXEHwJ_QaF=YXudqiUMY0MMpNY4mh-f+ABAx-Xg@mail.gmail.com>
 <CAPmaG0t++EtdGmVg_JOZt-MU1Su=BDAe7L-tv-un3qkQRkebfg@mail.gmail.com>
Message-ID: <1904642.oaMlk6atuQ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasanna,

On Monday 11 of November 2013 10:19:40 Prasanna Kumar wrote:
> On Mon, Nov 11, 2013 at 8:52 AM, Sachin Kamat <sachin.kamat@linaro.org>
> wrote:
> >
> > Hi Tomasz,
> >
> > Thanks for reviewing.
> >
> > On 10 November 2013 22:25, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > > Hi Sachin, Prasanna,
> > >
> > > [CCing Rafael and respective mailing lists]
> > >
> > > Please see my comments inline. Also please always remember to add all
> > > appropriate recipients on CC list. More reviewers means higher chance of
> > > spotting (and so eliminating) potential issues.
> >
> > Indeed. Thanks for adding. get_maintainers somehow did not list PM
> > related folks.
> > So missed this.
> >
> > >
> > > On Friday 08 of November 2013 11:57:05 Sachin Kamat wrote:
> > >> From: Prasanna Kumar <prasanna.ps@samsung.com>
> > >>
> > >> Power domain and device timing data are intialized with default
> > >> values to avoid dump of warnings from various power domains
> > >> during power gating.
> > >>
> > >> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> > >> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
> > >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > >> ---
> > >>  arch/arm/mach-exynos/pm_domains.c |   15 ++++++++++++++-
> > >>  1 file changed, 14 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/arm/mach-exynos/pm_domains.c
> > >> b/arch/arm/mach-exynos/pm_domains.c
> > >> index 84e0483a0500..9bbb4ac23980 100644
> > >> --- a/arch/arm/mach-exynos/pm_domains.c
> > >> +++ b/arch/arm/mach-exynos/pm_domains.c
> > >> @@ -25,6 +25,10 @@
> > >>  #include <mach/regs-pmu.h>
> > >>  #include <plat/devs.h>
> > >>
> > >> +#define DEFAULT_DEV_LATENCY_NS                       1000000UL
> > >> +#define DEFAULT_PD_PWRON_LATENCY_NS          10000000UL
> > >> +#define DEFAULT_PD_PWROFF_LATENCY_NS         10000000UL
> > >
> > > Is there any rationale behind choosing these particular values?
> >
> > IMO, these values were obtained more from experimentation. Prasanna,
> > please comment.
> As Sachin mentioned, the values are obtained from experimentation to avoid
> latency warning messages. These values can be changed when the
> information becomes available from the specs.
> As of now , this seems to be good set of values.

Do you have any measurements that confirm that there is no regression
in power consumption (e.g. caused by unnecessarily delayed runtime PM
operations) after applying this patch?

Best regards,
Tomasz

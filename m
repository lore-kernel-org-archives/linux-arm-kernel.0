From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 12:21:31 +0000
Subject: [PATCH] perf: xgene: Include module.h
In-Reply-To: <CACgAJHweQP7FTMHWJbW7YzfBKqbUAg+0v=aaTUK9qLs+EfyTqQ@mail.gmail.com>
References: <20170125234658.12071-1-sboyd@codeaurora.org>
 <CACgAJHweQP7FTMHWJbW7YzfBKqbUAg+0v=aaTUK9qLs+EfyTqQ@mail.gmail.com>
Message-ID: <20170126122131.GF14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 07:29:30PM -0800, Tai Tri Nguyen wrote:
> On Wed, Jan 25, 2017 at 3:46 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > I ran into a build error when I disabled CONFIG_ACPI and tried to
> > compile this driver:
> >
> > drivers/perf/xgene_pmu.c:1242:1: warning: data definition has no type or storage class
> >  MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
> >  ^
> > drivers/perf/xgene_pmu.c:1242:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
> >
> > Include module.h for the MODULE_DEVICE_TABLE macro that's
> > implicitly included through ACPI.
> >
> > Cc: Tai Nguyen <ttnguyen@apm.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/perf/xgene_pmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index a8ac4bcef2c0..fb3281962a6d 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -20,6 +20,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/module.h>
> 
> Please fix alphabetic order of the include file.
> 
> Tested-by: Tai Nguyen <ttnguyen@apm.com>

I've picked this up with the includes put in the correct order.

Thanks,

Will
